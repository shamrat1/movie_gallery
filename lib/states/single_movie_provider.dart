import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_gallery/models/home_response.dart';
import 'package:movie_gallery/models/movie_details_response.dart';
import 'package:movie_gallery/repo/movie_repo.dart';

final singleMovieProvider = FutureProvider.autoDispose
    .family<MovieDetail?, Result>((ref, result) async {
  if (result.mediaType == "tv") {
    return await MovieRepo().getTVDetails(result.id);
  }
  return await MovieRepo().getMovieDetails(result.id);
});
