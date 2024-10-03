import 'package:flutter/material.dart';
import 'package:medi_care_hub/core/router/routes.dart';
import 'package:medi_care_hub/features/login/presentation/views/login_view.dart';
import 'package:medi_care_hub/features/onboarding/presentation/views/on_boarding_view.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginView:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.onBoardingView:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
