import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:volt_market/core/networking/supabase_database_service.dart';
import 'package:volt_market/core/networking/supabase_storage_service.dart';
import 'package:volt_market/features/signup/model/profile.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController checkPasswordTextController =
      TextEditingController();
  final TextEditingController currentAddressTextController =
      TextEditingController();
  final TextEditingController fullNameTextController = TextEditingController();
  final TextEditingController zipTextController = TextEditingController();
  String dropdownValue = 'Cairo';
  File? imgFile;
  String? imgUrl =
      'https://i.pinimg.com/736x/01/4e/f2/014ef2f860e8e56b27d4a3267e0a193a.jpg';

  Future<void> signup() async {
    emit(Loading());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailTextController.text,
            password: passwordTextController.text,
          );
      await credential.user?.sendEmailVerification();
      if (imgFile != null) {
        imgUrl = await SupabaseStorageService().uploadProfilePicture(
          userId: credential.user!.uid,
          imageFile: imgFile!,
        );
      }
      final Profile profile = Profile(
        uuid: credential.user!.uid,
        name: fullNameTextController.text,
        email: emailTextController.text,
        address: currentAddressTextController.text,
        city: dropdownValue,
        zip: zipTextController.text,
        imgProfile: imgUrl!,
      );
      await SupabaseDatabaseService().insertUserProfile(profile);
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        emit(
          SignupFailed(errMsg: 'The account already exists for that email.'),
        );
      } else if (e.message!.contains('network')) {
        emit(SignupFailed(errMsg: 'Check your network 🥺'));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(SignupFailed(errMsg: e.toString()));
    }
  }
}
