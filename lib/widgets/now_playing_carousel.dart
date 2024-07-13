import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_gallery/widgets/carousel_item.dart';
import '../models/now_playing_response.dart';
import '../states/now_playing_provider.dart';

class NowPlayingCarousel extends StatelessWidget {
  const NowPlayingCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      AsyncValue<NowPlayingResponse?> nowPlaying =
          ref.watch(nowPlayingProvider);

      return switch (nowPlaying) {
        AsyncData(:final value) => _buildView(value),
        AsyncError(:final error) => Center(child: Text('Error: $error')),
        _ => SizedBox(
            height: 200.h,
            child: Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            )),
          ),
      };
    });
  }

  Widget _buildView(NowPlayingResponse? value) {
    return CarouselSlider(
      items: value?.results.map((v) => CarouselItem(result: v)).toList(),
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
    );
  }
}
