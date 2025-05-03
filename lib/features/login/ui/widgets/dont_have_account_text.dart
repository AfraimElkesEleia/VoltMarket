import 'package:flutter/material.dart';
import 'package:volt_market/core/helper/device_utils.dart';
import 'package:volt_market/core/helper/navigation_helper.dart';
import 'package:volt_market/core/routing/my_routes.dart';
import 'package:volt_market/core/theme/text_styles.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    final darkmode = DeviceUtils.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: TextStyles.font18BlackBold.copyWith(
            color: darkmode ? Colors.blue : Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () => context.pushNamed(MyRoutes.signupScreen),
          child: Text(
            'Sign Up',
            style: TextStyles.font18LighBlue.copyWith(
              color: darkmode ? Colors.white : Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
