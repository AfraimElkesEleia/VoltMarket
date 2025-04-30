import 'package:supabase_flutter/supabase_flutter.dart';

class CartService {
  final SupabaseClient _supabase;

  CartService() : _supabase = Supabase.instance.client;

  /// Adds a product variant to the cart (or updates quantity if already exists)
  Future<void> addToCart({
    required String userId,
    required int productId,
    required int productVariantId,
    required int quantity,
    required double price,
  }) async {
    try {
      // 1. Check if user has an active cart (pending order)
      final activeOrderResponse =
          await _supabase
              .from('orders')
              .select('id')
              .eq('user_id', userId)
              .eq('status', 'pending')
              .maybeSingle();

      int orderId;

      // 2. If no active cart, create one
      if (activeOrderResponse == null) {
        final newOrderResponse =
            await _supabase
                .from('orders')
                .insert({
                  'user_id': userId,
                  'total_amount': 0, // Updated by database trigger
                  'status': 'pending',
                })
                .select('id')
                .single();

        orderId = newOrderResponse['id'] as int;
      } else {
        orderId = activeOrderResponse['id'] as int;
      }

      // 3. Check if item already exists in cart
      final existingItemResponse =
          await _supabase
              .from('order_items')
              .select('id, quantity')
              .eq('order_id', orderId)
              .eq('product_variant_id', productVariantId)
              .maybeSingle();

      if (existingItemResponse != null) {
        // Update existing item
        final newQuantity =
            (existingItemResponse['quantity'] as int) + quantity;
        await _supabase
            .from('order_items')
            .update({'quantity': newQuantity, 'total': newQuantity * price})
            .eq('id', existingItemResponse['id']);
      } else {
        // Add new item to cart
        await _supabase.from('order_items').insert({
          'order_id': orderId,
          'product_variant_id': productVariantId,
          'quantity': quantity,
          'price': price,
          'total': quantity * price,
        });
      }
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  /// Removes an item from the cart
  Future<void> removeFromCart(int itemId) async {
    try {
      await _supabase.from('order_items').delete().eq('id', itemId);
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  // /// Gets the total number of items in the cart
  // Future<int> getCartItemsCount(String userId) async {
  //   try {
  //     final response = await _supabase
  //         .from('orders')
  //         .select('id')
  //         .eq('user_id', userId)
  //         .eq('status', 'pending')
  //         .maybeSingle();

  //     if (response == null) return 0;

  //     final orderId = response['id'] as int;
  //     final itemsResponse = await _supabase
  //   .from('order_items')
  //   .select('id', const Options(head: false, count: CountOption.exact))
  //   .eq('order_id', orderId)
  //   .execute();

  //     return itemsResponse.length ?? 0;
  //   } catch (e) {
  //     throw Exception('Failed to get cart count: $e');
  //   }
  // }

  /// Fetches all items in the user's cart
  Future<List<Map<String, dynamic>>> getCartItems(String userId) async {
    try {
      final orderResponse =
          await _supabase
              .from('orders')
              .select('id')
              .eq('user_id', userId)
              .eq('status', 'pending')
              .maybeSingle();

      if (orderResponse == null) return [];

      final orderId = orderResponse['id'] as int;
      final itemsResponse = await _supabase
          .from('order_items')
          .select('''
            *,
            product_variants:product_variant_id(*),
            products:product_variants!inner(product_id(*))
          ''')
          .eq('order_id', orderId);

      return List<Map<String, dynamic>>.from(itemsResponse);
    } catch (e) {
      throw Exception('Failed to fetch cart items: $e');
    }
  }
}
