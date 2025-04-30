import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:volt_market/core/networking/favourite_service.dart';
import 'package:volt_market/features/products/data/model/category.dart';
import 'package:volt_market/features/products/data/model/product.dart';
import 'package:volt_market/features/products/data/service/product_service.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  late final ProductService _productService;
  late final FavoriteService _favoriteService;
  late final User? _currentUser;
  List<Product> products = [];
  List<Category> categories = [];
  ProductCubit() : super(ProductInitial()) {
    _productService = ProductService();
    _favoriteService = FavoriteService();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  // Fetch all products
  Future<void> fetchAllProducts() async {
    try {
      emit(Loading());
      products = await _productService.getAllProducts();
      // Check favorite status for each product
      final productsWithFavorites = await Future.wait(
        products.map((product) async {
          final isFav =
              _currentUser != null
                  ? await _favoriteService.isFavorite(
                    _currentUser.uid,
                    product.id,
                  )
                  : false;
          return product.copyWith(isFavorite: isFav);
        }),
      );
      emit(ProductsLoaded(products: productsWithFavorites));
    } catch (e) {
      emit(ProductError('Failed to fetch products: ${e.toString()}'));
    }
  }

  // Fetch products by category
  Future<void> fetchProductsByCategory(int categoryId) async {
    try {
      emit(Loading());
      products = await _productService.getProductsByCategory(categoryId);
      // Check favorite status for each product
      final productsWithFavorites = await Future.wait(
        products.map((product) async {
          final isFav =
              _currentUser != null
                  ? await _favoriteService.isFavorite(
                    _currentUser.uid,
                    product.id,
                  )
                  : false;
          return product.copyWith(isFavorite: isFav);
        }),
      );
      emit(ProductsLoaded(products: productsWithFavorites));
    } catch (e) {
      emit(ProductError('Failed to fetch category products: ${e.toString()}'));
    }
  }

  // Fetch all categories
  Future<void> fetchAllCategories() async {
    try {
      emit(Loading());
      final categories = await _productService.getAllCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(ProductError('Failed to fetch categories: ${e.toString()}'));
    }
  }

  // Search products
  Future<void> searchProducts(String query) async {
    try {
      emit(Loading());
      products = await _productService.searchProducts(query);
      // emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductError('Failed to search products: ${e.toString()}'));
    }
  }

  // Get single product by ID
  Future<Product?> getProductById(int productId) async {
    try {
      return await _productService.getProductById(productId);
    } catch (e) {
      emit(ProductError('Failed to fetch product: ${e.toString()}'));
      return null;
    }
  }

  Future<void> toggleFavorite(int productId) async {
    if (_currentUser == null) return;

    try {
      // Get current state
      if (state is! ProductsLoaded) return;
      final currentState = state as ProductsLoaded;

      // Find the product and its current favorite status
      final product = currentState.products.firstWhere(
        (p) => p.id == productId,
        orElse: () => throw Exception('Product not found'),
      );

      // Show loading immediately
      emit(
        ProductActionProcessing(productId: productId, isFavoriteAction: true),
      );

      // Toggle in backend
      if (product.isFavorite) {
        await _favoriteService.removeFromFavorites(_currentUser.uid, productId);
      } else {
        await _favoriteService.addToFavorites(_currentUser.uid, productId);
      }

      // Update UI with new state
      final updatedProducts =
          currentState.products.map((p) {
            return p.id == productId
                ? p.copyWith(isFavorite: !p.isFavorite)
                : p;
          }).toList();

      emit(ProductsLoaded(products: updatedProducts));
    } catch (e) {
      emit(ProductError('Failed to toggle favorite'));
    }
  }
}
