import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/home_response.dart';
import '../repo/movie_repo.dart';

final allTrendingProvider =
    FutureProvider.autoDispose<HomeResponse?>((ref) async {
  return await MovieRepo().getHomeData();
});
