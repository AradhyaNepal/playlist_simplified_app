import 'package:flutter/material.dart';
import 'package:playlist_simplified_app/common/constants/image_constants.dart';
import 'package:playlist_simplified_app/common/widget/custom_loading_indicator.dart';
import 'package:playlist_simplified_app/features/home/home_screen.dart';
import 'package:playlist_simplified_app/features/manage/repository/video_repository.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/splash-screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      final navigator = Navigator.of(context);
      await VideoRepository().init();

      navigator.pushReplacementNamed(HomeScreen.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImageConstants.splashJPG,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).viewPadding.top,
            child: const CustomLoadingIndicator(),
          ),
        ],
      ),
    );
  }
}
