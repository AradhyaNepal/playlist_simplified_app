import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playlist_simplified_app/features/manage/controller/video_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ManageVideosScreen extends ConsumerWidget {
  const ManageVideosScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final videoList=ref.watch(videoProvider);
    return CupertinoPageScaffold(
      child: SafeArea(
        child: ListView.builder(
          itemBuilder: (context,index){
            return ListTile(
              title: ,
            );
          },
        ),
      ),
    );
  }
}
