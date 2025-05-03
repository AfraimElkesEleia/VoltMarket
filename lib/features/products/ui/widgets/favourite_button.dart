import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/features/products/data/model/product.dart';
import 'package:volt_market/features/products/logic/cubit/product_cubit.dart';

class FavouriteButton extends StatelessWidget {
  final Product product;
  const FavouriteButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen:
          (previous, current) =>
              current is ProductsLoaded ||
              (current is ProductActionProcessing &&
                  current.productId == product.id) ||
              current is ProductError,
      builder: (context, state) {
        // Handle loading state for this specific product
        if (state is ProductActionProcessing &&
            state.productId == product.id &&
            state.isFavoriteAction) {
          return const SizedBox(
            width: 24,
            height: 24,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        // Get current favorite status (from updated state if available)
        final isFavorite =
            context
                .read<ProductCubit>()
                .products
                .firstWhere((p) => p.id == product.id, orElse: () => product)
                .isFavorite;
        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            size: 16,
            color: isFavorite ? Colors.red : Colors.blue,
          ),
          onPressed:
              () => context.read<ProductCubit>().toggleFavorite(product.id),
          splashRadius: 20, // Smaller splash effect
          padding: EdgeInsets.zero, // Tighter padding
          constraints: const BoxConstraints(), // Remove default constraints
        );
      },
    );
  }
}
