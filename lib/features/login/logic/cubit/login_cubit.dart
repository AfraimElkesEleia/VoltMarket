import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:volt_market/core/networking/supabase_database_service.dart';
import 'package:volt_market/features/login/helper/facebook_auth_service.dart';
import 'package:volt_market/features/signup/model/profile.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final formKey = GlobalKey<FormState>();
  final emailTextEditingControler = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final forgetPasswordTextController = TextEditingController();
  Future<void> signin() async {
    try {
      emit(Loading());
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextEditingControler.text,
        password: passwordTextEditingController.text,
      );
      if (!credential.user!.emailVerified) {
        emit(EmailNotVerified());
      } else {
        emit(SinginSuccess());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        emit(SigninFailed(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        emit(SigninFailed(message: 'Wrong password provided for that user.'));
      } else if (e.message!.contains('network')) {
        emit(SigninFailed(message: 'Check your network 🥺'));
      } else {
        emit(SigninFailed(message: e.toString()));
      }
    }
  }

  Future<void> resetPassword() async {
    try {
      emit(Loading());
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: forgetPasswordTextController.text,
      );
      emit(ResetPasswordEmailIsSent());
    } on FirebaseAuthException catch (e) {
      if (e.message!.contains('network')) {
        emit(SigninFailed(message: 'Check your network 🥺'));
      }
    } catch (e) {
      emit(ForgetPasswordErrorOccured(message: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(Loading());
    try {
      // Check internet connection (optional, using connectivity_plus)
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        emit(
          SigninFailed(
            message: 'No internet connection. Please check your network.',
          ),
        );
        return;
      }

      // Trigger Google sign-in flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(GoogleAuthUserNull()); // User cancelled the sign-in
        return;
      }

      // Obtain auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      await checkIfUserExist(userCredential); // Your custom logic
      emit(SinginSuccess());
    } on PlatformException catch (e) {
      final errorMessage =
          e.message?.contains('network_error') ?? false
              ? 'Check your network 🥺'
              : e.message ?? 'Google sign-in failed.';
      emit(SigninFailed(message: errorMessage));
    } on FirebaseAuthException catch (e) {
      final errorMessage =
          e.message?.contains('network') ?? false
              ? 'Check your network 🥺'
              : e.message ?? 'Firebase authentication failed.';
      emit(SigninFailed(message: errorMessage));
    } on TimeoutException catch (_) {
      emit(
        SigninFailed(message: 'Google sign-in timed out. Please try again.'),
      );
    } catch (e) {
      debugPrint('Google sign-in error: $e');
      emit(GoogleAuthUserNull()); // Fallback for unexpected errors
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final FacebookAuthService facebookAuthService = FacebookAuthService();
      emit(Loading());
      final userCredential = await facebookAuthService.signInWithFacebook();
      final bool isNewUser =
          userCredential?.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser) {
        final userData = await facebookAuthService.getCurrentUserData();
        debugPrint(userData.toString());
        final String name = userData!['name']??'';
        final String email = userData['email']??'';
        final String imageUrl = userData['picture']['data']['url']??'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTcvh7Ca8__Pj5OQDdGii_3ucmXdgw-XsQf-glPYClSoDgbkl41';

        await SupabaseDatabaseService().insertUserProfile(
          Profile(
            uuid: userCredential!.user!.uid,
            name: name,
            email: email,
            imgProfile: imageUrl,
          ),
        );
      }
      emit(SinginSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage =
              "This Facebook account is linked to another sign-in method.";
          break;
        case 'invalid-credential':
          errorMessage = "Invalid Facebook credential. Please try again.";
          break;
        case 'user-disabled':
          errorMessage = "Your account has been disabled. Contact support.";
          break;
        default:
          errorMessage = "Firebase authentication failed: ${e.message}";
      }
      emit(SigninFailed(message: errorMessage));
    } on TimeoutException catch (e) {
      emit(SigninFailed(message: e.message ?? "Request timed out."));
    } on PlatformException catch (e) {
      emit(SigninFailed(message: "Facebook sign-in error: ${e.message}"));
    } catch (e) {
      emit(SigninFailed(message: "An unexpected error occurred: $e"));
    }
  }
}

Future<void> checkIfUserExist(UserCredential userCredential) async {
  final bool isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
  final User? user = userCredential.user;
  if (isNewUser) {
    final String name = user?.displayName ?? 'No name';
    final String email = user?.email ?? 'No email';
    final String photoUrl = user?.photoURL ?? '';
    final String uuid = user!.uid;
    await SupabaseDatabaseService().insertUserProfile(
      Profile(uuid: uuid, name: name, email: email, imgProfile: photoUrl),
    );
    debugPrint('Insert is done');
  }
}
