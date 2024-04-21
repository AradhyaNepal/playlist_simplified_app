import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playlist_simplified_app/features/home/widget/youtube_screen.dart';
import 'package:playlist_simplified_app/features/manage/controller/video_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String route = "/home-screen";

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
    final items = ref.watch(videoProvider).map(
          (e) => YoutubeScreen(videoId: e),
        ).toList();
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
            } else {
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
