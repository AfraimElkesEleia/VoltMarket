import 'package:flutter/material.dart';
import 'package:volt_market/features/products/models/models.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(product: product, quantity: 1);
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    _items[productId]?.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    if (_items[productId] != null && _items[productId]!.quantity > 1) {
      _items[productId]!.quantity--;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  double get totalPrice {
    return _items.values.fold(
      0.0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
