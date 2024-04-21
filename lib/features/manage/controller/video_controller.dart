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

  void update(int index,String youtubeId) {
    final list=[...state];
    list[index]=youtubeId;
    state=[...list];
    VideoRepository().videoList=list;
  }
  void remove(int index) {
    final list=[...state];
    list.removeAt(index);
    state=[...list];
    VideoRepository().videoList=list;
  }

  void moveToUp(int indexToUp){
    if(indexToUp==0)return;
    var indexToDown=indexToUp-1;
    final list=[...state];
    final upItemTemp=list[indexToUp];
    list[indexToUp]=list[indexToDown];
    list[indexToDown]=upItemTemp;
    state=[...list];
    VideoRepository().videoList=list;
  }

}