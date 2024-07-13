import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_gallery/screens/movie_details.dart';
import 'package:overlapped_carousel/overlapped_carousel.dart';

import '../models/now_playing_response.dart';
import '../states/upcoming_provider.dart';

class UpcomingCardsCarousel extends StatelessWidget {
  const UpcomingCardsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      AsyncValue<NowPlayingResponse?> upcoming =
          ref.watch(upcomingMovieProvider);
      var screenWidth = MediaQuery.of(context).size.width;
      var screenHeight = MediaQuery.of(context).size.height;
      var minHeight = min(screenWidth / 3.3 * (16 / 9), screenHeight * .9);
      return switch (upcoming) {
        AsyncData(:final value) => _buildView(value, context, minHeight),
        AsyncError(:final error) => Center(child: Text('Error: $error')),
        _ => SizedBox(
            height: minHeight,
            child: Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            )),
          ),
      };
    });
  }

  Widget _buildView(
      NowPlayingResponse? value, BuildContext context, double height) {
    return Center(
      child: SizedBox(
        height: height,
        child: OverlappedCarousel(
          widgets: List.generate(
              value?.results.length ?? 0,
              (i) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) =>
                                  MovieDetailPage(movie: value!.results[i])));
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: value?.results[i].posterPath ??
                            "", //Images stored in assets folder
                        fit: BoxFit.fill,
                      ),
                    ),
                  )), //List of widgets
          currentIndex: 2,
          onClicked: (index) {
            print("Clicked on $index");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) =>
                        MovieDetailPage(movie: value!.results[index])));
          },
          obscure: 0.4,
          skewAngle: 0.25,
        ),
      ),
    );
  }
}
