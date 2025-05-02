import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volt_market/features/signup/model/profile.dart';

class SupabaseDatabaseService {
  SupabaseDatabaseService._create();
  static final SupabaseDatabaseService _supabaseDatabaseService =
      SupabaseDatabaseService._create();
  factory SupabaseDatabaseService() => _supabaseDatabaseService;

  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Get current authenticated user's ID
  String? get currentUserId => FirebaseAuth.instance.currentUser!.uid;

  SupabaseClient get supabaseClient => _supabaseClient;
  Future<void> insertUserProfile(Profile profile) async {
    try {
      await _supabaseClient.from('users').upsert(profile.toMap());
    } catch (e) {
      throw Exception('Failed to insert profile: $e');
    }
  }

  // Get current user's profile
  Future<Profile> getCurrentUserProfile() async {
    try {
      if (currentUserId == null) throw Exception('User not authenticated');

      final response =
          await _supabaseClient
              .from('users')
              .select()
              .eq('id', currentUserId!)
              .single();

      return Profile.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }

  // Insert or update full profile
  Future<void> upsertUserProfile(Profile profile) async {
    try {
      await _supabaseClient.from('users').upsert(profile.toMap());
    } catch (e) {
      throw Exception('Failed to upsert profile: $e');
    }
  }

  // Update individual fields
  Future<void> updateUserName(String newName) async {
    try {
      if (currentUserId == null) throw Exception('User not authenticated');

      await _supabaseClient
          .from('users')
          .update({
            'full_name': newName,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', currentUserId!);
    } catch (e) {
      throw Exception('Failed to update name: $e');
    }
  }

  Future<void> updateUserEmail(String newEmail) async {
    try {
      if (currentUserId == null) throw Exception('User not authenticated');

      await _supabaseClient
          .from('users')
          .update({
            'email': newEmail,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', currentUserId!);
    } catch (e) {
      throw Exception('Failed to update email: $e');
    }
  }

  Future<void> updateUserAddress(String newAddress) async {
    try {
      if (currentUserId == null) throw Exception('User not authenticated');

      await _supabaseClient
          .from('users')
          .update({
            'address': newAddress,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', currentUserId!);
    } catch (e) {
      throw Exception('Failed to update address: $e');
    }
  }

  Future<void> updateUserCity(String newCity) async {
    try {
      if (currentUserId == null) throw Exception('User not authenticated');

      await _supabaseClient
          .from('users')
          .update({
            'city': newCity,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', currentUserId!);
    } catch (e) {
      throw Exception('Failed to update city: $e');
    }
  }

  Future<void> updateUserZip(String newZip) async {
    try {
      if (currentUserId == null) throw Exception('User not authenticated');

      await _supabaseClient
          .from('users')
          .update({
            'zip': newZip,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', currentUserId!);
    } catch (e) {
      throw Exception('Failed to update zip: $e');
    }
  }
}
