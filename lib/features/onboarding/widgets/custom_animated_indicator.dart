import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_market/core/theme/colors_manager.dart';

class CustomAnimatedIndicator extends StatelessWidget {
  final bool active;
  const CustomAnimatedIndicator({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      width: active ? 30.w : 8.w,
      height: 6.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: active ? ColorsManager.buttonColor : Colors.grey,
      ),
    );
  }
}
