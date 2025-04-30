part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class Loading extends ProductState {}

final class ProductsIsLoading extends ProductState {}

final class CategoryIsLoading extends ProductState {}

final class ProductsLoaded extends ProductState {
  late final List<Product> products;
  late final List<Category> categories;
  ProductsLoaded({required this.products, required this.categories});
}

// final class CategoryProductsLoaded extends ProductState {
//   final List<Product> products;
//   final List<Category> categories;

//   CategoryProductsLoaded({required this.products, required this.categories});
// }

// final class CategoriesLoaded extends ProductState {
//   final List<Category> categories;

//   CategoriesLoaded(this.categories);
// }

final class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
