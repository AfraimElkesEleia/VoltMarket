import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  SupabaseStorageService._create();
  static final SupabaseStorageService _supabaseStorageService =
      SupabaseStorageService._create();
  factory SupabaseStorageService() => _supabaseStorageService;

  final _client = Supabase.instance.client;

  static const String _profileBucket = 'users-profile';
  //The path is not related to the user's device - it's purely a virtual storage path for Supabase Storage.
  String _getUserProfilePath(String userId) => 'profiles/$userId/pic';

  /// Uploads a profile picture from device storage
  Future<String?> uploadProfilePicture({
    required String userId,
    required File imageFile,
  }) async {
    try {
      // Check if bucket exists, create if not
      final fileExtension = path.extension(imageFile.path);
      debugPrint('Storage passed file Extention $fileExtension');
      final mimeType = lookupMimeType(imageFile.path);
      debugPrint('Storage passed file Mime:$mimeType');

      final fileBytes = await imageFile.readAsBytes();
      debugPrint('Storage passed file Bytes:$fileBytes');
      final storagePath = '${_getUserProfilePath(userId)}$fileExtension';
      debugPrint('Storage passed file Path:$storagePath');

      // Upload to Supabase Storage
      await _client.storage
          .from(_profileBucket)
          .uploadBinary(
            storagePath,
            fileBytes,
            fileOptions: FileOptions(contentType: mimeType, upsert: true),
          );
      debugPrint('Storage done');

      // Get public URL
      return '${getProfilePictureUrl(userId)}$fileExtension';
    } catch (e) {
      debugPrint('Error uploading profile picture: $e');
      throw Exception(e);
    }
  }

  String? getProfilePictureUrl(String userId) {
    try {
      return _client.storage
          .from(_profileBucket)
          .getPublicUrl(_getUserProfilePath(userId));
    } catch (e) {
      debugPrint('Error getting profile picture URL: $e');
      return null;
    }
  }
}
