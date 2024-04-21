import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playlist_simplified_app/features/manage/repository/video_repository.dart';

final videoProvider=StateNotifierProvider<VideoNotifier, List<String>>((ref) {
  final item=VideoRepository().videoList;
  return VideoNotifier(item);
});


class VideoNotifier extends StateNotifier<List<String>> {

  VideoNotifier(super.state);

  void add(String youtubeId) {
    state=[...state,youtubeId];
    VideoRepository().videoList=state;
  }

  void remove(String youtubeId) {
    final list=[...state];
    list.removeWhere((element) => element==youtubeId);
    state=[...list];
    VideoRepository().videoList=list;
  }

}