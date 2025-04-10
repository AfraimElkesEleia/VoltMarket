import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_market/core/helper/spacing_helper.dart';
import 'package:volt_market/core/widgets/button_app_widget.dart';

class SocialNetworkButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;
  const SocialNetworkButton({
    super.key,
    this.color,
    this.textColor,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonAppWidget(
      onTap: onTap,
      color: color ?? Colors.white,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          horizontalSpace(10),
          Text(
            text,
            style: TextStyle(fontSize: 18.sp, color: textColor ?? Colors.white),
          ),
        ],
      ),
    );
  }
}
