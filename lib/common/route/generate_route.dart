import 'package:flutter/material.dart';
import 'package:playlist_simplified_app/features/home/home_screen.dart';
import 'package:playlist_simplified_app/features/splash/splash_screen.dart';

class GenerateRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings route) {
    switch (route.name) {
      case SplashScreen.route:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case HomeScreen.route:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_)=>const SplashScreen(),
        );
    }
  }
}
