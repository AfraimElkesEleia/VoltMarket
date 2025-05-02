import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volt_market/core/helper/sharedpref_helper.dart';
import 'package:volt_market/core/routing/app_router.dart';
import 'package:volt_market/core/routing/my_routes.dart';
import 'package:volt_market/core/volt_market.dart';
import 'package:volt_market/features/cart/logic/cartprovider.dart';
import 'package:volt_market/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://ydaqlquykysikhtjguyg.supabase.co',
    anonKey: 'your-key-here',
  );

  late String initialRoute;

  if (await SharedprefHelper.checkFirstTime()) {
    initialRoute = MyRoutes.onboardingScreen;
  } else {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || !user.emailVerified) {
      initialRoute = MyRoutes.loginScreen;
    } else {
      initialRoute = MyRoutes.navigationMenu;
    }
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: VoltMarket(appRouter: AppRouter(), initialRoute: initialRoute),
    ),
  );
}
