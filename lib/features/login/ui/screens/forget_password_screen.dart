import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/core/helper/app_regex.dart';
import 'package:volt_market/core/helper/spacing_helper.dart';
import 'package:volt_market/core/theme/text_styles.dart';
import 'package:volt_market/core/widgets/button_app_widget.dart';
import 'package:volt_market/core/widgets/text_app_widget.dart';
import 'package:volt_market/features/login/logic/cubit/login_cubit.dart';
import 'package:volt_market/features/login/ui/widgets/build_bloc_listener.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final forgetPasswordFormKey = GlobalKey<FormState>();
  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Form(
              key: forgetPasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forget Password',
                    style: TextStyles.font40BlackExtraBold,
                  ),
                  verticalSpace(10),
                  Text(
                    'Enter your email address\nto reset password',
                    style: TextStyles.font20LightGreySemiBold,
                  ),
                  verticalSpace(20),
                  TextAppWidget(
                    textEditingController:
                        context.read<LoginCubit>().forgetPasswordTextController,
                    text: 'Email',
                    prefixIcon: Icons.email,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Email is required';
                      } else if (!AppRegex.checkEmailText(email)) {
                        return 'Email is invalid!!';
                      }
                      return null;
                    },
                  ),
                  verticalSpace(30),
                  ButtonAppWidget(
                    onTap: () {
                      if (forgetPasswordFormKey.currentState!.validate()) {
                        context.read<LoginCubit>().resetPassword();
                        debugPrint('reset password');
                      } else {
                        debugPrint('operation is invalid');
                      }
                    },
                    text: 'Reset Password',
                    textStyle: TextStyles.font16WhiteRegulare,
                  ),
                  BuildBlocListener(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
