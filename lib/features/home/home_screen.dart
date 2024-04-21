import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playlist_simplified_app/common/constants/color_constants.dart';
import 'package:playlist_simplified_app/common/utils/custom_orientation.dart';
import 'package:playlist_simplified_app/features/home/widget/youtube_screen.dart';
import 'package:playlist_simplified_app/features/manage/controller/currently_playing_controller.dart';
import 'package:playlist_simplified_app/features/manage/controller/video_controller.dart';
import 'package:playlist_simplified_app/features/manage/view/manage_videos_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String route = "/home-screen";

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _controller = PageController();

  @override
  void initState() {
    super.initState();
    CustomOrientation.fullScreen();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(changeCurrentlyPlayingProvider, (_, next) {
      if (next == null) return;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOut,
      );
    });
    final items = ref
        .watch(videoProvider)
        .map(
          (e) => YoutubeScreen(videoId: e),
        )
        .toList();
    return Stack(
      children: [
        Positioned.fill(
          child: PageView.builder(
            key: ValueKey(items.length),
            onPageChanged: (value) {
              ref
                  .read(currentlyPlayingProvider.notifier)
                  .update((state) => value);
            },
            controller: _controller,
            itemBuilder: (context, index) {
              return NotificationListener<YoutubeNextNotification>(
                onNotification: (_) {
                  if (index < items.length - 1) {
                    _moveTo(index+1);
                  } else {
                    _moveTo(0);
                  }
                  return true;
                },
                child: items[index],
              );
            },
            itemCount: items.length,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).viewPadding.top + 50.r,
          right: 50.r,
          child: Row(
            children: [
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.5),
                ),
                child: IconButton(
                  onPressed: () {
                    _moveTo(1);
                  },
                  icon: Icon(
                    Icons.repeat,
                    color: Colors.green,
                    size: 50.r,
                  ),
                ),
              ),
              SizedBox(width: 5.w,),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.5),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ManageVideosScreen.route);
                  },
                  icon: Icon(
                    Icons.settings,
                    color: ColorConstants.primaryColor,
                    size: 50.r,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _moveTo(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
