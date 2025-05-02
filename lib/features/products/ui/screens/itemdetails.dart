import 'package:flutter/material.dart';
import 'package:volt_market/core/helper/device_utils.dart';
import 'package:volt_market/core/theme/colors_manager.dart';
import 'package:volt_market/features/products/models/models.dart';
import 'package:volt_market/features/products/ui/widgets/ratingdisplay.dart';

class Itemdetails extends StatelessWidget {
  final Product product;
  const Itemdetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final darkmode = DeviceUtils.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border_outlined, color: Colors.red),
            onPressed: () {
              // TODO: Add to favorites functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              // used the stack to implement the icons on top but wasn't good looking so added them to the appbar instead
              children: [
                Container(color: Colors.white, height: 450),
                // Product Image
                Container(
                  height: 450,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(product.image),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),

            // Product Info Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // product Ratin and review count
                  Row(
                    children: [
                      RatingDisplay(rating: product.rating, starSize: 20),
                      const SizedBox(width: 8),
                      Text(
                        '(${product.reviewCount} reviews)',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Price
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: darkmode ? Colors.white : Colors.black,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),

                        backgroundColor: ColorsManager.buttonColor,
                      ),
                      onPressed: () {
                        // TODO: add "add to cart" logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} added to cart!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 18,
                          color: darkmode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              ///
            ),
          ],
        ),
      ),
    );
  }
}
