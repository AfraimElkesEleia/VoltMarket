import 'package:volt_market/features/products/data/model/product.dart';

class CartItem {
  final int id;
  final int productId;
  int quantity;
  final DateTime addedAt;
  final Product product;
  final ProductVariant? variant;

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.addedAt,
    required this.product,
    this.variant,
  });

  // Calculate total price for this cart item
  double get totalPrice {
    // Get base product price
    double price = product.price;
    // Multiply by quantity
    return price * quantity;
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as int,
      productId: map['product_id'] as int,
      quantity: map['quantity'] as int,
      addedAt: DateTime.parse(map['added_at'] as String),
      product: Product.fromJson(map['products'] as Map<String, dynamic>),
      variant:
          map['product_variants'] != null
              ? ProductVariant.fromJson(
                map['product_variants'] as Map<String, dynamic>,
              )
              : null,
    );
  }
}

class ProductVariant {
  final int id;
  final String? color;
  final String? storage;
  final Product product;

  ProductVariant({
    required this.id,
    this.color,
    this.storage,
    required this.product,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'] as int,
      color: json['color'] as String?,
      storage: json['storage'] as String?,
      product: Product.fromJson(json['product']),
    );
  }
}
