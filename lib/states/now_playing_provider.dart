import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repo/movie_repo.dart';
import '../models/now_playing_response.dart';

final nowPlayingProvider =
    FutureProvider.autoDispose<NowPlayingResponse?>((ref) async {
  return await MovieRepo().getNowPlaying();
});
