import 'package:volt_market/features/products/data/model/product.dart';

class FavouriteItem {
  final String? imageUrl;
  final String title;
  final String? description;
  final double price;
  final int productId;

  FavouriteItem({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.productId,
  });
  factory FavouriteItem.fromProduct(Product product) {
    return FavouriteItem(
      imageUrl: product.imgUrl,
      title: product.title,
      description: product.description,
      price: product.price,
      productId: product.id,
    );
  }
}
