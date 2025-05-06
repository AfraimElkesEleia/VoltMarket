import 'package:supabase_flutter/supabase_flutter.dart';

class CartService {
  late final SupabaseClient _supabase;

  CartService() {
    _supabase = Supabase.instance.client;
  }

  // Add item to cart
  Future<void> addToCart({
    required int productId,
    required String userId,
    int quantity = 1,
  }) async {
    final existingItem =
        await _supabase
            .from('cart_items')
            .select()
            .eq('user_id', userId)
            .eq('product_id', productId)
            .maybeSingle();

    if (existingItem != null) {
      // Update quantity if item exists
      await _supabase
          .from('cart_items')
          .update({
            'quantity': existingItem['quantity'] + quantity,
            'added_at': DateTime.now().toIso8601String(),
          })
          .eq('id', existingItem['id']);
    } else {
      // Add new item if it doesn't exist
      await _supabase.from('cart_items').insert({
        'user_id': userId,
        'product_id': productId,
        'quantity': quantity,
      });
    }
  }

  // Remove item from cart
  Future<void> removeFromCart(int cartItemId, String userId) async {
    await _supabase
        .from('cart_items')
        .delete()
        .eq('product_id', cartItemId)
        .eq('user_id', userId);
  }

  // Update item quantity in cart
  Future<void> updateQuantity(
    int cartItemId,
    String userId,
    int newQuantity,
  ) async {
    if (newQuantity <= 0) {
      return removeFromCart(cartItemId, userId);
    }

    await _supabase
        .from('cart_items')
        .update({'quantity': newQuantity})
        .eq('product_id', cartItemId)
        .eq('user_id', userId);
  }

  // Get all cart items with product details
  Future<List<Map<String, dynamic>>> getCartItems(String userId) async {
    final response = await _supabase
        .from('cart_items')
        .select('''
          *, 
          products(*),
          product_variants(*)
        ''')
        .eq('user_id', userId)
        .order('added_at', ascending: false);

    return response;
  }

  // Get cart item count
  Future<int> getCartItemCount(String userId) async {
    final response = await _supabase
        .from('cart_items')
        .select('id')
        .eq('user_id', userId);

    return response.length;
  }

  // Clear entire cart
  Future<void> clearCart(String userId) async {
    await _supabase.from('cart_items').delete().eq('user_id', userId);
  }

  // Check if a product is in the cart
  Future<bool> isProductInCart(
    String userId,
    int productId, {
    int? variantId,
  }) async {
    final query = _supabase
        .from('cart_items')
        .select()
        .eq('user_id', userId)
        .eq('product_id', productId);
    final response = await query.maybeSingle();
    return response != null;
  }
}
