import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/now_playing_response.dart';
import '../repo/movie_repo.dart';

final upcomingMovieProvider =
    FutureProvider.autoDispose<NowPlayingResponse?>((ref) async {
  return await MovieRepo().getUpcoming();
});
