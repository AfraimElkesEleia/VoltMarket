import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReviewService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Insert or update a review
  Future<void> submitReview({
    required int productId,
    required int rating,
  }) async {
    final user = _auth.currentUser;
    final userId = user!.uid;
    await _supabase.from('reviews').upsert(onConflict: 'user_id,product_id', {
      'user_id': userId,
      'product_id': productId,
      'rating': rating,
    });
  }

  /// Get average rating for a specific product
  Future<double> getAverageRating(int productId) async {
    final response = await _supabase
        .from('reviews')
        .select('rating')
        .eq('product_id', productId);
    if (response.isEmpty) return 0.0;
    final ratings = response.map((e) => e['rating'] as int).toList();
    final average = ratings.reduce((a, b) => a + b) / ratings.length;
    return double.parse(average.toStringAsFixed(2));
  }
}
