import 'package:flutter/material.dart';
import 'package:playlist_simplified_app/features/home/widget/youtube_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String route = "/home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      const YoutubeScreen(videoId: "CUT_hdgbV1I"),
      const YoutubeScreen(videoId: "v=VAnAIi-Vdcg"),
      const YoutubeScreen(videoId: "yRyiswHx07I"),
      const YoutubeScreen(videoId: "m2OpffdcjNM"),
    ];
    return PageView.builder(
      itemBuilder: (context, index) {
        return items[index];
      },
      itemCount: items.length,
    );
  }
}
