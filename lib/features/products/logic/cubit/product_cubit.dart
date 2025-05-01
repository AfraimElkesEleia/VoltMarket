import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:volt_market/core/networking/cart_service.dart';
import 'package:volt_market/core/networking/favourite_service.dart';
import 'package:volt_market/features/products/data/model/cart_item.dart';
import 'package:volt_market/features/products/data/model/category.dart';
import 'package:volt_market/features/products/data/model/product.dart';
import 'package:volt_market/features/products/data/service/product_service.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  late final ProductService _productService;
  late final FavoriteService _favoriteService;
  late final CartService _cartService;
  late final User? _currentUser;
  List<Product> products = [];
  List<Category> categories = [];
  ProductCubit() : super(ProductInitial()) {
    _productService = ProductService();
    _favoriteService = FavoriteService();
    _cartService = CartService();
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
      final productsWithCartUpdate = await Future.wait(
        productsWithFavorites.map((product) async {
          final isInCart =
              _currentUser != null
                  ? await _cartService.isProductInCart(
                    _currentUser.uid,
                    product.id,
                  )
                  : false;
          return product.copyWith(isInCart: isInCart);
        }),
      );
      emit(ProductsLoaded(products: productsWithCartUpdate));
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
      final productsWithCartUpdate = await Future.wait(
        productsWithFavorites.map((product) async {
          final isInCart =
              _currentUser != null
                  ? await _cartService.isProductInCart(
                    _currentUser.uid,
                    product.id,
                  )
                  : false;
          return product.copyWith(isInCart: isInCart);
        }),
      );
      emit(ProductsLoaded(products: productsWithCartUpdate));
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
      final currentState = state as ProductsLoaded;
      // DO NOT emit yet. Save product list before emitting.
      final updatedProducts =
          currentState.products.map((p) {
            if (p.id == productId) {
              return p.copyWith(isFavorite: !p.isFavorite);
            }
            return p;
          }).toList();

      // Now emit the loading indicator
      emit(
        ProductActionProcessing(
          productId: productId,
          isFavoriteAction: true,
          isCartAction: false,
        ),
      );
      final bool isFavorite = await _favoriteService.isFavorite(
        _currentUser.uid,
        productId,
      );
      // Call backend
      if (isFavorite) {
        await _favoriteService.removeFromFavorites(_currentUser.uid, productId);
      } else {
        await _favoriteService.addToFavorites(_currentUser.uid, productId);
      }

      // Now emit the final updated state using saved updatedProducts
      emit(ProductsLoaded(products: updatedProducts));
    } catch (e) {
      emit(ProductError('Failed to toggle favorite ${e.toString()}'));
    }
  }

  Future<void> toggleCartItem({required Product product}) async {
    if (_currentUser == null) {
      emit(ProductError('Please login to manage your cart'));
      return;
    }

    final isInCart = product.isInCart;

    try {
      // ✅ Extract current product list before emitting new state
      if (state is! ProductsLoaded) return;
      final currentState = state as ProductsLoaded;
      final currentProducts = currentState.products;

      // ⏳ Emit loading state
      emit(
        ProductActionProcessing(
          productId: product.id,
          isCartAction: true,
          isFavoriteAction: false,
        ),
      );

      // 🔁 Toggle cart status in backend
      if (isInCart) {
        await _cartService.removeFromCart(product.id, _currentUser.uid);
      } else {
        await _cartService.addToCart(
          productId: product.id,
          userId: _currentUser.uid,
          quantity: 1,
        );
      }

      // 🛠️ Update the product locally
      final updatedProducts =
          currentProducts.map((p) {
            if (p.id == product.id) {
              return p.copyWith(isInCart: !p.isInCart); // ✅ Correct field
            }
            return p;
          }).toList();

      // ✅ Emit updated product list
      emit(ProductsLoaded(products: updatedProducts));
    } catch (e) {
      emit(ProductError('Failed to toggle cart item: ${e.toString()}'));
    }
  }
}
