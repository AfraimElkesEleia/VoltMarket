import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_market/core/routing/app_router.dart';

class VoltMarket extends StatelessWidget {
  final AppRouter appRouter;
  final String initialRoute;

  const VoltMarket({
    super.key,
    required this.appRouter,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
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
