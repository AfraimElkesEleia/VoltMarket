import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_market/core/theme/font_weight_helper.dart';

abstract class TextStyles {
  static TextStyle font20PoppinsWhiteBold = TextStyle(
    color: Colors.white,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
  );
  static TextStyle font12PoppinsWhiteThin = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeightHelper.thin,
    fontSize: 12.sp,
    color: Colors.white,
  );
  static TextStyle font16WhiteBold = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16.sp,
  );
}
