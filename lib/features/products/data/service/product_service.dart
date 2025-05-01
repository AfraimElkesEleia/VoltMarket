import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volt_market/features/products/data/model/category.dart';
import 'package:volt_market/features/products/data/model/product.dart';

class ProductService {
  final SupabaseClient _supabase;

  ProductService() : _supabase = Supabase.instance.client;

  // Fetch all products
  Future<List<Product>> getAllProducts() async {
    try {
      final response = await _supabase
          .from('products')
          .select('*')
          .order('created_at', ascending: false);

      if (response.isEmpty) return [];

      return response.map<Product>((product) => Product.fromJson(product)).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  // Fetch products by category ID
  Future<List<Product>> getProductsByCategory(int categoryId) async {
    try {
      final response = await _supabase
          .from('products')
          .select('*')
          .eq('category_id', categoryId)
          .order('created_at', ascending: false);

      if (response.isEmpty) return [];

      return response.map<Product>((product) => Product.fromJson(product)).toList();
    } catch (e) {
      throw Exception('Failed to fetch products by category: $e');
    }
  }

  // Fetch all categories
  Future<List<Category>> getAllCategories() async {
    try {
      final response = await _supabase
          .from('categories')
          .select('*')
          .order('name', ascending: true);

      if (response.isEmpty) return [];

      return response.map<Category>((category) => Category.fromJson(category)).toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  // Search products by title
  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await _supabase
          .from('products')
          .select('*')
          .ilike('title', '%$query%')
          .order('created_at', ascending: false);

      if (response.isEmpty) return [];

      return response.map<Product>((product) => Product.fromJson(product)).toList();
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  // Get product by ID
  Future<Product?> getProductById(int productId) async {
    try {
      final response = await _supabase
          .from('products')
          .select('*')
          .eq('id', productId)
          .single();

      return Product.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}