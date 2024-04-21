import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

class VideoRepository {
  static const String videosKey="videosKeys";
  static const String _boxName = "LocalStorage";
  static final VideoRepository _instance = VideoRepository._();

  VideoRepository._();

  factory VideoRepository()=>_instance;

  late final Box _hiveBox;

  Box get hiveBox=>_hiveBox;

  void init()async{
    await Hive.initFlutter();
    try {
      _hiveBox = await Hive.openBox(_boxName);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }
  }

  List<String> get videoList{
    final item=_hiveBox.get(videosKey);
    if(item is List<String>){
      final items = [
        "CUT_hdgbV1I",
        "DLqzbColpcE",
        "yRyiswHx07I",
        "m2OpffdcjNM",
      ];
      _hiveBox.put(videosKey,items);
      return items;
    }else{
      return item;
    }

  }
}
