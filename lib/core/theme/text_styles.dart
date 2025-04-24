import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_market/core/theme/font_weight_helper.dart';

abstract class TextStyles {
  //* **************onBoarding screen ************* */
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
  //* ***************button app widget ************ */
  static TextStyle font18WhiteSemiBolde = TextStyle(
    color: Colors.white,
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.semiBold,
  );
  //* **************login screen******************* */
  static TextStyle font18BlackBold = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font18LighBlue = TextStyle(
    color: Colors.blue[700],
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  //* ************** forget password screen ************ */
  static TextStyle font40BlackExtraBold = TextStyle(
    fontSize: 40.sp,
    color: Colors.black,
    fontWeight: FontWeightHelper.extraBold,
  );
  static TextStyle font20LightGreySemiBold = TextStyle(
    fontSize: 20.sp,
    color: Colors.grey[600],
    fontWeight: FontWeightHelper.semiBold,
  );
  static TextStyle font16WhiteRegulare = TextStyle(
    fontSize: 16.sp,
    color: Colors.white,
  );
}
