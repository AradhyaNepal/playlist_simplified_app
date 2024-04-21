import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:playlist_simplified_app/common/constants/color_constants.dart';
import 'package:playlist_simplified_app/common/widget/custom_dialog.dart';
import 'package:playlist_simplified_app/common/widget/custom_network_image.dart';
import 'package:playlist_simplified_app/features/manage/controller/currently_playing_controller.dart';
import 'package:playlist_simplified_app/features/manage/controller/video_controller.dart';
import 'package:playlist_simplified_app/features/manage/view/widget/add_edit_video_dialog.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class IndividualManageVideo extends ConsumerWidget {
  final String item;
  final int index;

  const IndividualManageVideo({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(currentlyPlayingProvider) == index;
    return Stack(
      children: [
        CustomNetworkImage(
          YoutubePlayer.getThumbnail(
            videoId: item,
          ),
          height: 300.h,
          width: double.infinity,
        ),
        Positioned(
          top: 5.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context){
                      return AddEditVideoDialog(forEditIndex: index);
                    },
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: () async {
                  final selected = await showDialog(
                    context: context,
                    builder: (_) => const CustomDialog(
                      heading: "Delete",
                      description: "Are you sure you want to delete?",
                    ),
                  );
                  if (selected == true) {
                    ref.read(videoProvider.notifier).remove(index);
                  }
                },
                icon: const Icon(
                  Icons.delete,
                  color: ColorConstants.primaryColor,
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Center(
            child: isPlaying
                ? SpinKitWave(
                    size: 50.r,
                    color: Colors.white,
                  )
                : IconButton(
                    onPressed: () {
                      ref
                          .read(changeCurrentlyPlayingProvider.notifier)
                          .update((state) => index);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.play_circle,
                      size: 50.r,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
