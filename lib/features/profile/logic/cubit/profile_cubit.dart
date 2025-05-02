import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:volt_market/core/networking/supabase_database_service.dart';
import 'package:volt_market/core/networking/supabase_storage_service.dart';
import 'package:volt_market/features/signup/model/profile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SupabaseDatabaseService _service = SupabaseDatabaseService();
  final SupabaseStorageService _storageService = SupabaseStorageService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Profile? profile;
  File? img;
  final User? currentUser = FirebaseAuth.instance.currentUser;
  ProfileCubit() : super(ProfileInitial());

  Future<void> fetchProfile() async {
    emit(Loading());
    try {
      profile = await _service.getCurrentUserProfile();
      emit(ProfileLoaded());
    } catch (e) {
      emit(ProfileError('Failed to load profile'));
    }
  }

  // Add other update methods (address, city, zip...) as needed
  Future<void> updateProfile(Profile updatedProfile) async {
    emit(Loading());
    try {
      // Check which fields actually changed
      final currentProfile = profile;

      if (currentProfile == null || currentUser == null) {
        throw Exception('No profile loaded');
      }

      // Update only changed fields
      if (currentProfile.name != updatedProfile.name &&
          updatedProfile.name.isNotEmpty) {
        await _service.updateUserName(updatedProfile.name);
        await currentUser!.updateDisplayName(updatedProfile.name);
      }
      if (currentProfile.address != updatedProfile.address &&
          updatedProfile.address!.isNotEmpty) {
        await _service.updateUserAddress(updatedProfile.address!);
      }

      if (currentProfile.city != updatedProfile.city &&
          updatedProfile.city!.isNotEmpty) {
        await _service.updateUserCity(updatedProfile.city!);
      }

      if (currentProfile.zip != updatedProfile.zip &&
          updatedProfile.zip!.isNotEmpty) {
        await _service.updateUserZip(updatedProfile.zip!);
      }

      // Fetch the updated profile
      profile = await _service.getCurrentUserProfile();
      emit(ProfileLoaded());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // ****************** //
  Future<void> updateProfileImage() async {
    emit(Loading());
    try {
      if (currentUser == null) {
        throw Exception('No user logged in');
      }

      // Upload to Supabase Storage
      final imageUrl = await _storageService.uploadProfilePicture(
        userId: currentUser!.uid,
        imageFile: img!,
      );

      if (imageUrl == null) {
        throw Exception('Failed to upload image');
      }

      // Update profile with new image URL
      await _service.supabaseClient
          .from('users')
          .update({
            'img_profile': imageUrl,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', currentUser!.uid);

      await currentUser!.updatePhotoURL(imageUrl);

      // Refresh profile
      profile = await _service.getCurrentUserProfile();
      debugPrint('Upload Image done');
      emit(ProfileLoaded());
    } catch (e) {
      emit(ProfileError('Failed to update profile image: $e'));
    }
  }

  // ****************** //
  Future<void> logout() async {
    emit(Loading());
    try {
      await FirebaseAuth.instance.signOut();
      emit(LoggedOut());
    } catch (e) {
      emit(ProfileError('Failed to logout'));
    }
  }
}
