import 'dart:io';

import 'package:movie_gallery/models/credits_response.dart';
import 'package:movie_gallery/models/home_response.dart';
import 'package:movie_gallery/models/movie_details_response.dart';
import 'package:movie_gallery/models/now_playing_response.dart';
import 'package:movie_gallery/utils/http/http_client.dart';

class MovieRepo {
  Future<HomeResponse?> getHomeData() async {
    try {
      final response = await THttpHelper.get("trending/all/day?language=en-US");
      print(response);
      return HomeResponse.fromJson(response);
    } on SocketException catch (e) {}
  }

  Future<MovieDetail?> getMovieDetails(int id) async {
    try {
      var casts = await getCredits(id);

      final response = await THttpHelper.get("movie/$id?language=en-US");
      var details = MovieDetail.fromJson(response);
      if (casts != null) {
        details.casts = casts.cast;
      }
      return details;
    } on SocketException catch (e) {}
  }

  Future<MovieDetail?> getTVDetails(int id) async {
    try {
      final response = await THttpHelper.get("tv/$id?language=en-US");
      print(response);
      return MovieDetail.fromJson(response);
    } on SocketException catch (e) {}
  }

  Future<CreditsResponse?> getCredits(int id) async {
    try {
      final response =
          await THttpHelper.get("movie/$id/credits?language=en-US");
      print(response);
      return CreditsResponse.fromJson(response);
    } on SocketException catch (e) {}
  }

  Future<NowPlayingResponse?> getNowPlaying() async {
    try {
      final response =
          await THttpHelper.get("movie/now_playing?language=en-US");
      print(response);
      return NowPlayingResponse.fromJson(response);
    } on SocketException catch (e) {}
  }

  Future<NowPlayingResponse?> getUpcoming() async {
    try {
      final response = await THttpHelper.get("movie/upcoming?language=en-US");
      print("++++++++++");
      print(response);
      return NowPlayingResponse.fromJson(response);
    } on SocketException catch (e) {}
  }
}
