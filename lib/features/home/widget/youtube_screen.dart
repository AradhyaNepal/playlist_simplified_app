import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playlist_simplified_app/common/constants/color_constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeScreen extends StatelessWidget {
  static const String route = "youtube";
  final String videoId;

  const YoutubeScreen({
    super.key,
    required this.videoId,
  });

  @override
  Widget build(BuildContext context) {
    return _YoutubeContent(
      key: ValueKey(videoId),
      videoId: videoId,
    );
  }
}

class _YoutubeContent extends StatefulWidget {
  final String videoId;

  const _YoutubeContent({
    super.key,
    required this.videoId,
  });

  @override
  State<_YoutubeContent> createState() => _YoutubeContentState();
}

class _YoutubeContentState extends State<_YoutubeContent> {
  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.videoId,
    flags: const YoutubePlayerFlags(
      mute: false,
      loop: false,
      autoPlay: true,
    ),
  );


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YoutubePlayer(
          onEnded: (_) {
            YoutubeNextNotification().dispatch(context);
          },
          controller: _controller,
          bottomActions: [
            const SizedBox(width: 14.0),
            CurrentPosition(),
            const SizedBox(width: 8.0),
            ProgressBar(
              isExpanded: true,
              colors: ProgressBarColors(
                playedColor: ColorConstants.primaryColor,
                bufferedColor: Colors.white,
                backgroundColor: ColorConstants.primaryColor.withOpacity(0.5),
                handleColor: ColorConstants.primaryColor,
              ),
            ),
            RemainingDuration(),
            const PlaybackSpeedButton(),
          ],
        ),
        Positioned.fill(
          bottom: 250.h,
          child: Container(
            color: Colors.black.withOpacity(0.2),
            height: double.infinity,
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}


class YoutubeNextNotification extends Notification{

}