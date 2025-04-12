import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
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
}
