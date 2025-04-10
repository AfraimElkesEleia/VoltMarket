import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:volt_market/core/constants/image_manager.dart';
import 'package:volt_market/core/helper/spacing_helper.dart';
import 'package:volt_market/features/login/ui/widgets/social_network_button.dart';

class SocialNetworkLogin extends StatelessWidget {
  const SocialNetworkLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SocialNetworkButton(
            onTap: () {},
            text: 'Continue with Google',
            textColor: Colors.black,
            icon: Image.asset(
              ImageManager.googleIcon,
              width: 30.w,
              height: 30.h,
            ),
          ),
          verticalSpace(10),
          SocialNetworkButton(
            text: 'Continue with Facebook',
            icon: Icon(
              FontAwesomeIcons.facebook,
              color: Colors.white,
              size: 30.w,
            ),
            color: Color(0xFF1877F2),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
