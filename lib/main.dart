import 'package:flutter/material.dart';
import 'package:playlist_simplified_app/common/route/generate_route.dart';
import 'package:playlist_simplified_app/features/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'भजन किर्तन',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: GenerateRoute.onGenerateRoute,
      initialRoute: SplashScreen.route,
    );
  }
}

