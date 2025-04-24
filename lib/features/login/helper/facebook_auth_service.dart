import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  // Function to handle Facebook login
  Future<UserCredential?> signInWithFacebook() async {
    try {
 final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception('No internet connection. Please check your network.');
    }      // Trigger the Facebook login flow
      final LoginResult loginResult = await _facebookAuth.login(
        permissions: ['email', 'public_profile'],
      );

      if (loginResult.status == LoginStatus.success) {
        // Get the user data
        final AccessToken accessToken = loginResult.accessToken!;
        // Create a credential from the access token
        final OAuthCredential credential = FacebookAuthProvider.credential(
          accessToken.tokenString,
        );

        // Sign in to Firebase with the Facebook credential
        final UserCredential userCredential = await _auth.signInWithCredential(
          credential,
        );

        // Get the signed-in user
        //final User? user = userCredential.user;
        return userCredential;
      } else if (loginResult.status == LoginStatus.cancelled) {
        throw Exception('Facebook login cancelled');
      } else if (loginResult.status == LoginStatus.failed) {
        throw Exception('Facebook login failed: ${loginResult.message}');
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  // Function to check if user is already logged in
  Future<bool> isLoggedIn() async {
    final user = _auth.currentUser;
    if (user != null) {
      // Check if the token is still valid
      final tokenResult = await _facebookAuth.accessToken;
      return tokenResult != null;
    }
    return false;
  }

  // Function to get current user data
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    if (await isLoggedIn()) {
      return await _facebookAuth.getUserData(
        fields: "email,name,picture.width(200)",
      );
    }
    return null;
  }
}
