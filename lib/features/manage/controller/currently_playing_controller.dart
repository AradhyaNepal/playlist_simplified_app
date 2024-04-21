import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentlyPlayingProvider=StateProvider<int>((ref) => 0);

final changeCurrentlyPlayingProvider=StateProvider<int?>((ref)=>null);