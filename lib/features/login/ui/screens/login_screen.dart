import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_market/core/helper/device_utils.dart';
import 'package:volt_market/core/helper/spacing_helper.dart';
import 'package:volt_market/core/theme/font_weight_helper.dart';
import 'package:volt_market/core/widgets/button_app_widget.dart';
import 'package:volt_market/features/login/logic/cubit/login_cubit.dart';
import 'package:volt_market/features/login/ui/widgets/build_bloc_listener.dart';
import 'package:volt_market/features/login/ui/widgets/dont_have_account_text.dart';
import 'package:volt_market/features/login/ui/widgets/email_and_password_fields.dart';
import 'package:volt_market/features/login/ui/widgets/or_text.dart';
import 'package:volt_market/features/login/ui/widgets/social_network_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkmode = DeviceUtils.isDarkMode(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Let\'s Sign You In',
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeightHelper.medium,
                    letterSpacing: 0.0,
                  ),
                ),
                verticalSpace(10),
                Text(
                  'Welcome back, You have \nbeen missed!',
                  style: TextStyle(
                    fontSize: 24,
                    color: darkmode ? Colors.white : Colors.grey[600],
                  ),
                  textAlign: TextAlign.start,
                ),
                verticalSpace(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: EmailAndPasswordFields(),
                ),
                verticalSpace(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ButtonAppWidget(
                    text: 'Login',
                    onTap: () {
                      if (context
                          .read<LoginCubit>()
                          .formKey
                          .currentState!
                          .validate()) {
                        context.read<LoginCubit>().signin();
                        debugPrint('done');
                      } else {
                        debugPrint('Not valid');
                      }
                    },
                  ),
                ),
                verticalSpace(20),
                OrText(),
                verticalSpace(20),
                SocialNetworkLogin(),
                verticalSpace(20),
                DontHaveAccountText(),
                BuildBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
