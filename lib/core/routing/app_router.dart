import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/core/routing/my_routes.dart';
import 'package:volt_market/features/login/logic/cubit/login_cubit.dart';
import 'package:volt_market/features/login/ui/screens/forget_password_screen.dart';
import 'package:volt_market/features/login/ui/screens/login_screen.dart';
import 'package:volt_market/features/main/navigation_screen.dart';
import 'package:volt_market/features/onboarding/screens/onboarding_screen.dart';
import 'package:volt_market/features/orders/logic/cubit/order_cubit.dart';
import 'package:volt_market/features/orders/ui/screens/order_screen.dart';
import 'package:volt_market/features/products/logic/cubit/product_cubit.dart';
import 'package:volt_market/features/products/ui/screens/products_screen.dart';
import 'package:volt_market/features/signup/logic/cubit/signup_cubit.dart';
import 'package:volt_market/features/signup/ui/screens/signup_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case MyRoutes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case MyRoutes.loginScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => LoginCubit(),
                child: LoginScreen(),
              ),
        );
      case MyRoutes.signupScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => SignupCubit(),
                child: SignupScreen(),
              ),
        );
      case MyRoutes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => LoginCubit(),
                child: ForgetPasswordScreen(),
              ),
        );
      case MyRoutes.mainScreen:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case MyRoutes.myOrdersScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => OrderCubit(),
                child: OrdersScreen(),
              ),
        );
    }
    return null;
  }
}
