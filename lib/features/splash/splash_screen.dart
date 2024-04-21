import 'package:flutter/material.dart';
import 'package:playlist_simplified_app/common/constants/image_constants.dart';

class SplashScreen extends StatelessWidget {
  static const String route = "/splash-screen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        ImageConstants.splashJPG,
        fit: BoxFit.contain,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
