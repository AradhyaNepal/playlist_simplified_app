import 'package:flutter/material.dart';
import 'package:playlist_simplified_app/features/home/home_screen.dart';
import 'package:playlist_simplified_app/features/manage/view/manage_videos_screen.dart';
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
        case ManageVideosScreen.route:
        return MaterialPageRoute(
          builder: (_) => const ManageVideosScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_)=>const SplashScreen(),
        );
    }
  }
}
