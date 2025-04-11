import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_market/core/theme/colors_manager.dart';

class TextAppWidget extends StatelessWidget {
  final String text;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool? isObsecure;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  const TextAppWidget({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.isObsecure,
    this.validator,
    this.textEditingController,
    this.keyboardType,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: isObsecure ?? false,
      decoration: InputDecoration(
        hintText: text,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
        contentPadding: EdgeInsets.all(20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorsManager.lightPurple, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
