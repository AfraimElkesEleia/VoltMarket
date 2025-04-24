import 'package:flutter/material.dart';
import 'package:volt_market/core/theme/colors_manager.dart';
import 'package:volt_market/core/theme/text_styles.dart';

class ButtonAppWidget extends StatelessWidget {
  final String? text;
  final Color? color;
  final Widget? child;
  final VoidCallback onTap;
  final double? elevation;
  final TextStyle? textStyle;
  const ButtonAppWidget({
    super.key,
    this.color,
    this.child,
    this.text,
    this.elevation,
    this.textStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? ColorsManager.lightShade,
        minimumSize: Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey),
        ),
        elevation: elevation ?? 2,
      ),
      child:
          child ??
          Text(text ?? '', style: textStyle ?? TextStyles.font18WhiteSemiBolde),
    );
  }
}
