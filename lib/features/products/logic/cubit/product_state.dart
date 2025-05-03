part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class Loading extends ProductState {}

final class CategoriesIsLoading extends ProductState {}

final class ProductsLoaded extends ProductState {}

final class CategoriesLoaded extends ProductState {}

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
