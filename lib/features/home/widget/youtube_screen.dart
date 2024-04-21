import 'package:flutter/material.dart';
import 'package:playlist_simplified_app/common/constants/color_constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeScreen extends StatefulWidget {
  static const String route = "youtube";
  final String videoId;

  const YoutubeScreen({
    super.key,
    required this.videoId,
  });

  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.videoId,
    flags: const YoutubePlayerFlags(
      mute: false,
      loop: true,
      autoPlay: false,
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {

    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      onEnded: (_){
        Navigator.pop(context);
      },
      controller: _controller,
      bottomActions:[
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
    );
  }
}
