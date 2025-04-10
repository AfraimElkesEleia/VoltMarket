import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_market/core/helper/spacing_helper.dart';
import 'package:volt_market/core/theme/font_weight_helper.dart';
import 'package:volt_market/core/theme/text_styles.dart';
import 'package:volt_market/core/widgets/button_app_widget.dart';
import 'package:volt_market/core/widgets/text_app_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Forget Password', style: TextStyles.font40BlackExtraBold),
                verticalSpace(10),
                Text(
                  'Enter your email address\nto reset password',
                  style: TextStyles.font20LightGreySemiBold,
                ),
                verticalSpace(20),
                TextAppWidget(
                  textEditingController: textController,
                  text: 'Email',
                  prefixIcon: Icons.email,
                ),
                verticalSpace(30),
                ButtonAppWidget(
                  onTap: () {},
                  text: 'Reset Password',
                  textStyle: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
