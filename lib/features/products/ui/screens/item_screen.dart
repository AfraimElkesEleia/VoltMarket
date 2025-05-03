import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/core/helper/device_utils.dart';
import 'package:volt_market/core/theme/colors_manager.dart';
import 'package:volt_market/features/products/ui/widgets/rating_display.dart';
import 'package:volt_market/features/products/data/model/product.dart';
import 'package:volt_market/features/products/logic/cubit/product_cubit.dart';

class Itemdetails extends StatelessWidget {
  final Product product;
  const Itemdetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final darkmode = DeviceUtils.isDarkMode(context);

    return Scaffold(
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          // Get the latest version of the product from state
          Product currentProduct = product;

          
            final updated = context.read<ProductCubit>().products.firstWhere(
              (p) => p.id == product.id,
            );
            currentProduct = updated;
            context.read<ProductCubit>().currentProduct = currentProduct;
            context.read<ProductCubit>().productRating = product.rating;
          

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      currentProduct.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      context.read<ProductCubit>().toggleFavorite(
                        currentProduct.id,
                      );
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          currentProduct.imgUrl ??
                              'https://t4.ftcdn.net/jpg/05/17/53/57/240_F_517535712_q7f9QC9X6TQxWi6xYZZbMmw5cnLMr279.jpg',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),

              // Product Info Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentProduct.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          RatingDisplay(),
                          const SizedBox(width: 8),
                          Text(
                            '(${currentProduct.rating} reviews)',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${currentProduct.price.toStringAsFixed(2)}',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        currentProduct.description ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          color: darkmode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: ColorsManager.buttonColor,
                          ),
                          onPressed: () {
                            context.read<ProductCubit>().toggleCartItem(
                              product: currentProduct,
                            );
                            if (!product.isInCart) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${currentProduct.title} added to cart!',
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${currentProduct.title} removed from cart!',
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: Text(
                            currentProduct.isInCart
                                ? 'Remove from Cart'
                                : 'Add to Cart',
                            style: TextStyle(
                              fontSize: 18,
                              color: darkmode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
