// To parse this JSON data, do
//
//     final nowPlayingResponse = nowPlayingResponseFromJson(jsonString);

import 'dart:convert';
import 'home_response.dart';

NowPlayingResponse nowPlayingResponseFromJson(String str) =>
    NowPlayingResponse.fromJson(json.decode(str));

String nowPlayingResponseToJson(NowPlayingResponse data) =>
    json.encode(data.toJson());

class NowPlayingResponse {
  int page;
  List<Result> results;

  NowPlayingResponse({
    required this.page,
    required this.results,
  });

  factory NowPlayingResponse.fromJson(Map<String, dynamic> json) =>
      NowPlayingResponse(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
