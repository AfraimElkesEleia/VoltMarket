import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volt_market/core/networking/cart_service.dart';
import 'package:volt_market/features/cart/model/cart_item.dart';
import 'package:volt_market/features/cart/logic/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  late final CartService _cartService;
  late final User? _currentUser;

  CartCubit() : super(CartInitial()) {
    _cartService = CartService();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final response = await _cartService.getCartItems(_currentUser!.uid);
      final items = response.map((item) => CartItem.fromMap(item)).toList();
      if (!isClosed) {
        emit(CartLoaded(items: items));
      }
    } catch (e) {
      emit(CartError(message: 'Failed to load cart: ${e.toString()}'));
    }
  }

  Future<void> removeFromCart(int cartItemId) async {
    if (state is! CartLoaded) return;

    final currentItems = (state as CartLoaded).items;
    emit(CartUpdating(items: currentItems));

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
    if (state is! CartLoaded) return;

    final currentItems = (state as CartLoaded).items;
    emit(CartUpdating(items: currentItems));

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
    if (state is! CartLoaded) return;

    final currentItems = (state as CartLoaded).items;
    emit(CartUpdating(items: currentItems));

    try {
      await _cartService.clearCart(userId);
      emit(CartLoaded(items: []));
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
    if (state is! CartLoaded) return 0.0;
    return (state as CartLoaded).items.fold(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );
  }
}
