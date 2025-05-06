import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cart_service.dart';

class OrderService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final CartService _cartService = CartService();

  Future<void> createOrder() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user!.uid;

    // Fetch cart items
    final cartItems = await _cartService.getCartItems(userId);

    if (cartItems.isEmpty) throw Exception("Cart is empty.");

    // Calculate total amount
    double totalAmount = 0.0;
    for (var item in cartItems) {
      final quantity = item['quantity'];
      final price =
          item['product_variants']?['price'] ??
          item['products']?['price'] ??
          0.0;
      totalAmount += (price * quantity);
    }

    // Insert order
    final orderInsertResponse =
        await _supabase
            .from('orders')
            .insert({'user_id': userId, 'total_amount': totalAmount})
            .select()
            .single();

    final orderId = orderInsertResponse['id'];

    // Prepare order items
    final orderItems =
        cartItems.map((item) {
          final productId = item['product_id'];
          final quantity = item['quantity'];
          final price =
              item['product_variants']?['price'] ??
              item['products']?['price'] ??
              0.0;
          final total = price * quantity;

          return {
            'order_id': orderId,
            'product_id': productId,
            'quantity': quantity,
            'price': price,
            'total': total,
          };
        }).toList();

    // Insert all order items
    await _supabase.from('order_items').insert(orderItems);

    // Clear cart
    await _cartService.clearCart(userId);
  }

  Future<List<Map<String, dynamic>>> getUserOrders() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) throw Exception("User not logged in.");

    final userId = user.uid;

    // Get all orders with nested order_items, products, and product_variants
    final response = await _supabase
        .from('orders')
        .select('''
      *,
      order_items(
        *,
        products(*)
      )
    ''')
        .eq('user_id', userId)
        .order('order_date', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }
}
