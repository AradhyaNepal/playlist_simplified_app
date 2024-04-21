import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playlist_simplified_app/features/home/widget/youtube_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/home-screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      const YoutubeScreen(videoId: "CUT_hdgbV1I"),
      const YoutubeScreen(videoId: "DLqzbColpcE"),
      const YoutubeScreen(videoId: "yRyiswHx07I"),
      const YoutubeScreen(videoId: "m2OpffdcjNM"),
    ];
    return PageView.builder(
      controller: _controller,
      itemBuilder: (context, index) {
        return NotificationListener<YoutubeNextNotification>(
          onNotification: (_) {
            if (index < items.length - 1) {
              _controller.animateToPage(
                index + 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }else{
              _controller.animateToPage(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
            return true;
          },
          child: items[index],
        );
      },
      itemCount: items.length,
    );
  }
}
