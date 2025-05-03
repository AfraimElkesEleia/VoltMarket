import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volt_market/core/helper/device_utils.dart';
import 'package:volt_market/core/helper/navigation_helper.dart';
import 'package:volt_market/core/helper/spacing_helper.dart';
import 'package:volt_market/core/routing/my_routes.dart';
import 'package:volt_market/core/theme/font_weight_helper.dart';
import 'package:volt_market/core/theme/text_styles.dart';
import 'package:volt_market/core/widgets/button_app_widget.dart';
import 'package:volt_market/features/signup/logic/cubit/signup_cubit.dart';
import 'package:volt_market/features/signup/ui/widgets/build_bloc_listener.dart';
import 'package:volt_market/features/signup/ui/widgets/pic_image_widget.dart';
import 'package:volt_market/features/signup/ui/widgets/registeration_form_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _picker = ImagePicker();
  Future<void> pickImage(BuildContext context) async {
    var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        context.read<SignupCubit>().imgFile = File(pickedImage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkmode = DeviceUtils.isDarkMode(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Text(
              'Register',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Getting Started',
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    color: darkmode ? Colors.white : Colors.black,
                  ),
                ),
                verticalSpace(10),
                Text(
                  'Seems you are new here,\nLet\'s set up your profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeightHelper.medium,
                    color: darkmode ? Colors.white : Colors.grey[700],
                  ),
                ),
                verticalSpace(10),
                Center(
                  child: PicImageWidget(
                    onPressed: () {
                      pickImage(context);
                    },
                  ),
                ),
                verticalSpace(10),
                RegisterationFormWidget(),
                verticalSpace(25),
                ButtonAppWidget(
                  onTap: () {
                    if (context
                        .read<SignupCubit>()
                        .formKey
                        .currentState!
                        .validate()) {
                      context.read<SignupCubit>().signup();
                    }
                  },
                  text: 'Continue',
                ),
                verticalSpace(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyles.font12PoppinsWhiteThin.copyWith(
                        fontWeight: FontWeightHelper.medium,
                        color: darkmode ? Colors.white : Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        bool isLastScreen = !Navigator.canPop(context);
                        if (isLastScreen) {
                          context.pushReplacementNamed(MyRoutes.loginScreen);
                        } else {
                          context.pop();
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                BuildBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
