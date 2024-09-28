import 'package:flutter/material.dart';
import 'package:poc_flutter/common/route/routes.dart';
import 'package:poc_flutter/feature/splash/ui/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashPage());
    }
  }
}
