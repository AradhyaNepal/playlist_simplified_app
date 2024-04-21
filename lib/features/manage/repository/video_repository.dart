import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class VideoRepository {
  static const String videosKey="videosKeys";
  static const String _boxName = "LocalStorage";
  static final VideoRepository _instance = VideoRepository._();

  VideoRepository._();

  factory VideoRepository()=>_instance;

  late final Box _hiveBox;

  Box get hiveBox=>_hiveBox;

  Future<void> init()async{
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
    if(item is! List<String> || kDebugMode){
      final items=[
        "GQ95alrpnC0",
        "3RqgDS8Lvak",
        "Yuex2EnsGiY",
        "fWMqVHvpYwc",
        "YSyrR0Qblhk",
        "oofKB5ayrDA",
        "0J1aNK16sFM",
        "RSPVq1ijicA",
        "AETFvQonfV8",
        "Be-XDNW7yWM"
      ];
      videoList=items;
      return items;
    }else{
      return item;
    }

  }

  set videoList (List<String> items){
    final toAdd=[...items];
   _hiveBox.put(videosKey, toAdd);
  }
}
