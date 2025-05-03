import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/core/helper/device_utils.dart';
import 'package:volt_market/features/products/data/model/product.dart';
import 'package:volt_market/features/products/logic/cubit/product_cubit.dart';

class CartButton extends StatelessWidget {
  final Product product;
  final int? variantId;
  final double? variantPrice;

  const CartButton({
    super.key,
    required this.product,
    this.variantId,
    this.variantPrice,
  });

  @override
  Widget build(BuildContext context) {
    final darkmode = DeviceUtils.isDarkMode(context);
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen:
          (previous, current) =>
              current is ProductsLoaded ||
              (current is ProductActionProcessing &&
                  current.productId == product.id) ||
              current is ProductError,
      builder: (context, state) {
        // Handle loading state
        if (state is ProductActionProcessing &&
            state.productId == product.id &&
            state.isCartAction &&
            state.isFavoriteAction == false) {
          return const SizedBox(
            width: 24,
            height: 24,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        // Get current cart status
        final isInCart =
            context
                .read<ProductCubit>()
                .products
                .firstWhere((p) => p.id == product.id, orElse: () => product)
                .isInCart;

        return IconButton(
          icon: Icon(
            isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
            size: 16,
            color:
                isInCart
                    ? darkmode
                        ? Colors.white
                        : Colors.blue
                    : Colors.blue,
          ),
          onPressed:
              () =>
                  context.read<ProductCubit>().toggleCartItem(product: product),
          splashRadius: 20,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        );
      },
    );
  }
}
