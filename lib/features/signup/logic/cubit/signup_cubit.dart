import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

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
}
