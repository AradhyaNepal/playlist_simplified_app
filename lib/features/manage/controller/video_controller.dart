import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoProvider=StateNotifierProvider((ref) => VideoNotifier([]));
class VideoNotifier extends StateNotifier<List<String>>{

  static
  VideoNotifier(super.state);

}