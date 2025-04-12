import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volt_market/features/signup/model/profile.dart';

class SupabaseDatabaseService {
  SupabaseDatabaseService._create();
  static final SupabaseDatabaseService _supabaseDatabaseService =
      SupabaseDatabaseService._create();
  factory SupabaseDatabaseService() => _supabaseDatabaseService;

  final SupabaseClient _supabaseClient = Supabase.instance.client;

  SupabaseClient get supabaseClient => _supabaseClient;
  Future<void> insertUserProfile(Profile profile) async {
    try {
      await _supabaseClient.from('users').upsert(profile.toMap());
    } catch (e) {
      throw Exception('Failed to insert profile: $e');
    }
  }
}
