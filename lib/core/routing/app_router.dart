import 'package:flutter/material.dart';
import 'package:volt_market/core/routing/my_routes.dart';
import 'package:volt_market/features/login/ui/screens/login_screen.dart';
import 'package:volt_market/features/onboarding/screens/onboarding_screen.dart';
import 'package:volt_market/features/signup/ui/screens/signup_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case MyRoutes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case MyRoutes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case MyRoutes.signupScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  Scaffold(body: Center(child: Text("There is no Route here"))),
        );
    }
  }
}
