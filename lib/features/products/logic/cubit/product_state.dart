part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class Loading extends ProductState {}

final class CategoriesIsLoading extends ProductState {}

final class ProductsLoaded extends ProductState {
  late final List<Product> products;
  ProductsLoaded({required this.products});
}

final class CategoryProductsLoaded extends ProductState {
  final List<Product> products;

  CategoryProductsLoaded({required this.products});
}

final class CategoriesLoaded extends ProductState {
  final List<Category> categories;

  CategoriesLoaded(this.categories);
}

final class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

// Action processing states
final class ProductActionProcessing extends ProductState {
  final int productId;
  final bool isFavoriteAction;
  final bool isCartAction;

  ProductActionProcessing({
    required this.productId,
    this.isFavoriteAction = false,
    this.isCartAction = false,
  });
}

final class FavoriteErrorOccured extends ProductState {}

final class CartItemAdded extends ProductState {
  final int productId;
  CartItemAdded(this.productId);
}
final class CartItemRemoved extends ProductState {
  final int productId;
  CartItemRemoved(this.productId);
}

