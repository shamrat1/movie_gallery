import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_gallery/widgets/carousel_item.dart';

import '../models/home_response.dart';
import '../states/all_trending_provider.dart';

class TrendingCarousel extends StatelessWidget {
  const TrendingCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      AsyncValue<HomeResponse?> trending = ref.watch(allTrendingProvider);

      return switch (trending) {
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

  Widget _buildView(HomeResponse? value) {
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
