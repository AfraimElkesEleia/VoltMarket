import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_market/core/theme/colors_manager.dart';
import 'package:volt_market/core/theme/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback? onTap;
  const CustomButton({super.key, required this.text, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(50.w, 30.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor:
            color != null
                ? ColorsManager.buttonColor
                : Colors.white.withOpacity(0),
      ),
      child: Text(text, style: TextStyles.font16WhiteBold),
    );
  }
}
