import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_market/core/routing/app_router.dart';
import 'package:volt_market/core/routing/my_routes.dart';

String initialRoute = MyRoutes.onboardingScreen;

class VoltMarket extends StatelessWidget {
  final AppRouter appRouter;
  const VoltMarket({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        onGenerateRoute: appRouter.generateRoute,
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
      ),
    );
  }
}
