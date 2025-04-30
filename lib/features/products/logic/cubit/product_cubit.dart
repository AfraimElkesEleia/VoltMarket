import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:volt_market/features/products/data/model/category.dart';
import 'package:volt_market/features/products/data/model/product.dart';
import 'package:volt_market/features/products/data/service/product_service.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  late final ProductService _productService;
  List<Product> products = [];
  List<Category> categories = [];
  ProductCubit() : super(ProductInitial()) {
    _productService = ProductService();
  }

  // Fetch all products
  Future<void> fetchAllProducts() async {
    try {
      emit(Loading());
      products = await _productService.getAllProducts();
      categories = await _productService.getAllCategories();
      emit(ProductsLoaded(products: products, categories: categories));
    } catch (e) {
      emit(ProductError('Failed to fetch products: ${e.toString()}'));
    }
  }

  // Fetch products by category
  Future<void> fetchProductsByCategory(int categoryId) async {
    try {
      emit(ProductsIsLoading());
      products = await _productService.getProductsByCategory(categoryId);
      emit(ProductsLoaded(products: products, categories: categories));
    } catch (e) {
      emit(ProductError('Failed to fetch category products: ${e.toString()}'));
    }
  }

  // Fetch all categories
  // Future<void> fetchAllCategories() async {
  //   try {
  //     emit(Loading());
  //     final categories = await _productService.getAllCategories();
  //     emit(CategoriesLoaded(categories));
  //   } catch (e) {
  //     emit(ProductError('Failed to fetch categories: ${e.toString()}'));
  //   }
  // }

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
}
