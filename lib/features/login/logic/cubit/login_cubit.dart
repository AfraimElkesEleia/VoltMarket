import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final formKey = GlobalKey<FormState>();
  final emailTextEditingControler = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final forgetPasswordTextController = TextEditingController();
}
