import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volt_market/core/helper/sharedpref_helper.dart';
import 'package:volt_market/core/routing/app_router.dart';
import 'package:volt_market/core/routing/my_routes.dart';
import 'package:volt_market/core/volt_market.dart';
import 'package:volt_market/firebase_options.dart';

void main() async {
  //Fix heidden Text Problem
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://ydaqlquykysikhtjguyg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlkYXFscXV5a3lzaWtodGpndXlnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQyMDMyMTYsImV4cCI6MjA1OTc3OTIxNn0.DgMOLguJ-Azptp3D0lgQxug1z8sDOED8YhAKpkHsr7s',
  );
  if (await SharedprefHelper.checkFirstTime()) {
    initialRoute = MyRoutes.onboardingScreen;
  } else {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null || !user.emailVerified ) {
        initialRoute = MyRoutes.loginScreen;
      } else {
        initialRoute = MyRoutes.mainScreen;
      }
    });
  }
  runApp(VoltMarket(appRouter: AppRouter()));
}
