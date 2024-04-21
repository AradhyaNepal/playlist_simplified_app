import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playlist_simplified_app/common/utils/custom_orientation.dart';
import 'package:playlist_simplified_app/common/widget/custom_network_image.dart';
import 'package:playlist_simplified_app/features/manage/controller/video_controller.dart';
import 'package:playlist_simplified_app/features/manage/view/widget/individual_manage_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ManageVideosScreen extends ConsumerStatefulWidget {
  static const String route = "/manage-videos";

  const ManageVideosScreen({super.key});

  @override
  ConsumerState<ManageVideosScreen> createState() => _ManageVideosScreenState();
}

class _ManageVideosScreenState extends ConsumerState<ManageVideosScreen> {
  @override
  void initState() {
    super.initState();
    CustomOrientation.removeFullScreen();
  }

  @override
  void dispose() {
    CustomOrientation.fullScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoList = ref.watch(videoProvider);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        brightness: Brightness.dark,
        previousPageTitle: "Manage",
      ),
      child: SafeArea(
        child: ListView.separated(
          separatorBuilder: (_, __) => SizedBox(
            height: 10.h,
          ),
          itemCount: videoList.length,
          itemBuilder: (context, index) {
            return IndividualManageVideo(
              item: videoList[index],
              index: index,
            );
          },
        ),
      ),
    );
  }
}
