import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volt_market/features/favourites/model/favourite_item.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    super.key,
    required this.item,
    required this.removeFromFavourites,
    required this.addToCart,
  });
  final FavouriteItem item;
  final VoidCallback removeFromFavourites;
  final VoidCallback addToCart;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(
              item.imageUrl ??
                  'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: removeFromFavourites,
              ),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart, color: Colors.blue),
                onPressed: addToCart,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
