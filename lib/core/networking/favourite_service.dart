import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volt_market/features/products/data/model/product.dart';

class FavoriteService {
  final SupabaseClient _supabase;

  FavoriteService() : _supabase = Supabase.instance.client;

  /// Adds a product to user's favorites
  Future<void> addToFavorites(String userId, int productId) async {
    try {
      await _supabase.from('favorites').insert({
        'user_id': userId,
        'product_id': productId,
      });
    } catch (e) {
      throw Exception('Failed to add to favorites: $e');
    }
  }

  /// Removes a product from user's favorites
  Future<void> removeFromFavorites(String userId, int productId) async {
    try {
      await _supabase
          .from('favorites')
          .delete()
          .eq('user_id', userId)
          .eq('product_id', productId);
    } catch (e) {
      throw Exception('Failed to remove from favorites: $e');
    }
  }

  /// Checks if a product is in user's favorites
  Future<bool> isFavorite(String userId, int productId) async {
    try {
      final response = await _supabase
          .from('favorites')
          .select()
          .eq('user_id', userId)
          .eq('product_id', productId);

      return response.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check favorite status: $e');
    }
  }

  /// Fetches all favorite products for a user
  Future<List<Product>> getUserFavorites(String userId) async {
    try {
      final response = await _supabase
          .from('favorites')
          .select('product_id')
          .eq('user_id', userId);

      if (response.isEmpty) return [];

      // Extract product IDs
      final productIds = response.map((fav) => fav['product_id'] as int).toList();

      // Fetch full product details
      final productsResponse = await _supabase
          .from('products')
          .select('*')
          .inFilter('id', productIds);

      return productsResponse.map<Product>((p) => Product.fromJson(p)).toList();
    } catch (e) {
      throw Exception('Failed to fetch favorites: $e');
    }
  }
}