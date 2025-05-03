import 'package:flutter/material.dart';
import 'package:volt_market/core/helper/device_utils.dart';
import 'package:volt_market/core/theme/colors_manager.dart';
import 'package:volt_market/features/products/data/model/product.dart';
import 'package:volt_market/features/products/ui/widgets/cart_button.dart';
import 'package:volt_market/features/products/ui/widgets/favourite_button.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final darkmode = DeviceUtils.isDarkMode(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      darkmode
                          ? ColorsManager.borderDark.withOpacity(0.2)
                          : ColorsManager.borderLight.withOpacity(0.2),
                  width: 1.5,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                color: Colors.grey[200],
                image: DecorationImage(
                  image:
                      product.imgUrl != null
                          ? NetworkImage(product.imgUrl!)
                          : const AssetImage('assets/placeholder.png')
                              as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Product Details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(product.rating.toStringAsFixed(1)),
                      ],
                    ),
                    const Spacer(),
                    FavouriteButton(product: product),
                    CartButton(product: product),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
