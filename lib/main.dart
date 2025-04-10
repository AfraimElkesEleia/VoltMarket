import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_market/core/helper/sharedpref_helper.dart';
import 'package:volt_market/core/routing/app_router.dart';
import 'package:volt_market/core/routing/my_routes.dart';
import 'package:volt_market/core/volt_market.dart';

void main() async {
  //Fix heidden Text Problem
  await ScreenUtil.ensureScreenSize();
  if(await SharedprefHelper.checkFirstTime()){
    initialRoute = MyRoutes.onboardingScreen;
  }else{
    initialRoute = MyRoutes.loginScreen;
  }
  runApp(VoltMarket(appRouter: AppRouter()));
}
