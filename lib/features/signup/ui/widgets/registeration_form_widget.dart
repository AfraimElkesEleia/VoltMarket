import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/core/helper/app_regex.dart';
import 'package:volt_market/core/helper/spacing_helper.dart';
import 'package:volt_market/core/widgets/text_app_widget.dart';
import 'package:volt_market/features/signup/logic/cubit/signup_cubit.dart';
import 'package:volt_market/features/signup/ui/widgets/password_validation_widget.dart';
import 'package:volt_market/features/signup/ui/widgets/zip_and_city_fields.dart';

class RegisterationFormWidget extends StatefulWidget {
  const RegisterationFormWidget({super.key});
  @override
  State<RegisterationFormWidget> createState() =>
      _RegisterationFormWidgetState();
}

class _RegisterationFormWidgetState extends State<RegisterationFormWidget> {
  late final TextEditingController passwordTextController;
  bool passwordObsecure = false;
  bool checkPasswordobsecure = false;
  bool hasUpperChar = false;
  bool hasLowerChar = false;
  bool hasSpecialChar = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordTextController = context.read<SignupCubit>().passwordTextController;
    setupPasswordValidation();
  }

  void setupPasswordValidation() {
    hasLowerChar = AppRegex.checkPasswordHasLowercase(
      passwordTextController.text,
    );
    hasUpperChar = AppRegex.checkPasswordHasUpperchar(
      passwordTextController.text,
    );
    hasSpecialChar = AppRegex.checkPasswordHasSpecialChar(
      passwordTextController.text,
    );
    hasNumber = AppRegex.checkPasswordHasNumber(passwordTextController.text);
    hasMinLength = AppRegex.checkPasswordHasMinLength(
      passwordTextController.text,
    );
    passwordTextController.addListener(() {
      setState(() {
        hasLowerChar = AppRegex.checkPasswordHasLowercase(
          passwordTextController.text,
        );
        hasUpperChar = AppRegex.checkPasswordHasUpperchar(
          passwordTextController.text,
        );
        hasSpecialChar = AppRegex.checkPasswordHasSpecialChar(
          passwordTextController.text,
        );
        hasNumber = AppRegex.checkPasswordHasNumber(
          passwordTextController.text,
        );
        hasMinLength = AppRegex.checkPasswordHasMinLength(
          passwordTextController.text,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignupCubit>().formKey,
      child: Column(
        children: [
          TextAppWidget(
            textEditingController:
                context.read<SignupCubit>().fullNameTextController,
            text: 'Full name',
            prefixIcon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Full name is required';
              }
              return null;
            },
          ),
          verticalSpace(20),
          TextAppWidget(
            textEditingController:
                context.read<SignupCubit>().emailTextController,
            text: 'Email',
            prefixIcon: Icons.email,
            validator: (email) {
              if (email == null || email.isEmpty) {
                return 'Email is required';
              } else if (!AppRegex.checkEmailText(email)) {
                return 'Email is not valid';
              }
              return null;
            },
          ),
          verticalSpace(20),
          TextAppWidget(
            textEditingController:
                context.read<SignupCubit>().currentAddressTextController,
            text: 'Current Address',
            prefixIcon: Icons.location_city,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Address is required';
              }
              return null;
            },
          ),
          verticalSpace(20),
          ZipAndCityFields(),
          verticalSpace(20),
          TextAppWidget(
            textEditingController:
                context.read<SignupCubit>().passwordTextController,
            text: 'Password',
            isObsecure: passwordObsecure,
            prefixIcon: Icons.password,
            suffixIcon: IconButton(
              onPressed: () {
                passwordObsecure = !passwordObsecure;
                setState(() {});
              },
              icon:
                  passwordObsecure
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
            ),
            validator: (password) {
              if (password == null || password.isEmpty) {
                return 'Password is required';
              } else if (!AppRegex.checkPasswordIsStrong(password)) {
                return 'Your Password is weak';
              }
              return null;
            },
          ),
          verticalSpace(10),
          PasswordValidationWidget(
            hasUpperChar: hasUpperChar,
            hasLowerChar: hasLowerChar,
            hasNumber: hasNumber,
            hasSpecialChar: hasSpecialChar,
            hasMinLength: hasMinLength,
          ),
          verticalSpace(10),
          TextAppWidget(
            textEditingController:
                context.read<SignupCubit>().checkPasswordTextController,
            text: 'Confirm Password',
            prefixIcon: Icons.password,
            isObsecure: checkPasswordobsecure,
            validator: (password) {
              if (password == null || password.isEmpty) {
                return 'You need to congirm your password';
              } else if (passwordTextController.text !=
                  context
                      .read<SignupCubit>()
                      .checkPasswordTextController
                      .text) {
                return 'Confirm password must be the same as password';
              }
              return null;
            },
            suffixIcon: IconButton(
              onPressed: () {
                checkPasswordobsecure = !checkPasswordobsecure;
                setState(() {});
              },
              icon:
                  checkPasswordobsecure
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
            ),
          ),
        ],
      ),
    );
  }
}
