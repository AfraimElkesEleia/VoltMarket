import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volt_market/core/networking/cart_service.dart';
import 'package:volt_market/core/networking/order_service.dart';
import 'package:volt_market/features/cart/model/cart_item.dart';
import 'package:volt_market/features/cart/logic/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  late final CartService _cartService;
  late final OrderService _orderService;
  late final User? _currentUser;
  List<CartItem> items = [];
  CartCubit() : super(CartInitial()) {
    _cartService = CartService();
    _orderService = OrderService();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final response = await _cartService.getCartItems(_currentUser!.uid);
      items = response.map((item) => CartItem.fromMap(item)).toList();
      if (!isClosed) {
        emit(CartLoaded());
      }
    } catch (e) {
      emit(CartError(message: 'Failed to load cart: ${e.toString()}'));
    }
  }

  Future<void> removeFromCart(int cartItemId) async {
    final currentItems = items;
    emit(CartRemoving());

    try {
      await _cartService.removeFromCart(cartItemId, _currentUser!.uid);
      await loadCart();
    } catch (e) {
      emit(
        CartError(
          message: 'Failed to remove item from cart: ${e.toString()}',
          items: currentItems,
        ),
      );
    }
  }

  Future<void> updateQuantity(int cartItemId, int newQuantity) async {
    final currentItems = items;
    emit(CartUpdating());

    try {
      await _cartService.updateQuantity(
        cartItemId,
        _currentUser!.uid,
        newQuantity,
      );
      await loadCart();
    } catch (e) {
      emit(
        CartError(
          message: 'Failed to update quantity: ${e.toString()}',
          items: currentItems,
        ),
      );
    }
  }

  Future<void> clearCart(String userId) async {
    final currentItems = items;
    emit(CartLoaded());

    try {
      await _cartService.clearCart(userId);
      items = [];
      emit(CartLoaded());
    } catch (e) {
      emit(
        CartError(
          message: 'Failed to clear cart: ${e.toString()}',
          items: currentItems,
        ),
      );
    }
  }

  double get totalPrice {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  /// 🔥 Create order and clear cart if successful
  Future<void> createOrderFromCart() async {
    if (items.isEmpty) {
      emit(CartIsEmpty());
      return;
    } // 🛑 Do nothing if cart is empty
    try {
      emit(CartUpdating());
      await _orderService.createOrder();
      await _cartService.clearCart(_currentUser!.uid);
      emit(OrderIsDone());
      await loadCart(); // reload empty cart
    } catch (e) {
      emit(
        CartError(
          message: 'Failed to create order: ${e.toString()}',
          items: items,
        ),
      );
    }
  }
}
