import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/core/constants/categories_icons.dart';
import 'package:volt_market/core/constants/image_manager.dart';
import 'package:volt_market/core/helper/navigation_helper.dart';
import 'package:volt_market/core/routing/my_routes.dart';
import 'package:volt_market/features/products/data/model/product.dart';
import 'package:volt_market/features/products/logic/cubit/product_cubit.dart';
import 'package:volt_market/features/products/ui/widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchAllProducts();
    context.read<ProductCubit>().fetchAllCategories();
  }

  void _filterByCategory(int? categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
      if (categoryId == null) {
        context.read<ProductCubit>().fetchAllProducts();
      } else {
        context.read<ProductCubit>().fetchProductsByCategory(categoryId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Row(
            children: [
              Image.asset(ImageManager.voltMarketLogo, width: 40, height: 40),
              Text(
                'Volt Market',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          floating: true,
        ),

        // Categories Section
        SliverToBoxAdapter(child: _buildCategoriesSection()),

        // Products Title
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverToBoxAdapter(
            child: Text(
              _selectedCategoryId == null
                  ? 'All Products'
                  : 'Category Products',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),

        // Products Grid
        _buildProductsGrid(),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen:
          (previous, current) =>
              current is CategoriesIsLoading ||
              current is CategoriesLoaded ||
              current is ProductError,
      builder: (context, state) {
        if (state is Loading) {
          return const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CategoriesLoaded) {
          return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  context.read<ProductCubit>().categories.length +
                  1, // +1 for "All" option
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _filterByCategory(null),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor:
                                _selectedCategoryId == null
                                    ? Colors.blue[100]
                                    : Colors.grey[200],
                            child: Image.asset(ImageManager.all),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text('All'),
                      ],
                    ),
                  );
                }

                final category =
                    context.read<ProductCubit>().categories[index - 1];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _filterByCategory(category.id),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor:
                              _selectedCategoryId == category.id
                                  ? Colors.blue[100]
                                  : Colors.grey[200],
                          child: Image.asset(categoriesIcons[index - 1]),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(category.name),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return SizedBox(
            height: 100,
            child: Center(child: Text("state.message")),
          );
        }
      },
    );
  }

  Widget _buildProductsGrid() {
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen:
          (previous, current) =>
              current is Loading ||
              current is ProductsLoaded ||
              current is ProductError,
      builder: (context, state) {
        if (state is Loading) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ProductError) {
          return SliverToBoxAdapter(child: Center(child: Text(state.message)));
        }

        List<Product> products = [];

        if (state is ProductsLoaded) {
          products = context.read<ProductCubit>().products;
        } else {
          return const SliverToBoxAdapter(
            child: Center(child: Text('No products to display')),
          );
        }

        if (products.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(child: Text('No products found')),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 300,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed(
                    MyRoutes.productDetailScreen,
                    arguments: products[index],
                  );
                },
                child: ProductCard(product: products[index]),
              );
            }, childCount: products.length),
          ),
        );
      },
    );
  }
}
