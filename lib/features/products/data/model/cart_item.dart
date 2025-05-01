import 'package:volt_market/features/products/data/model/product.dart';

class CartItem {
  final int id;
  final int quantity;
  final double price;
  final double total;
  final ProductVariant variant;

  CartItem({
    required this.id,
    required this.quantity,
    required this.price,
    required this.total,
    required this.variant,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as int,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      variant: ProductVariant.fromJson(json['variant']),
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
