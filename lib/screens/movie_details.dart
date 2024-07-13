import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_gallery/models/home_response.dart';
import 'package:movie_gallery/models/movie_details_response.dart';
import 'package:movie_gallery/states/single_movie_provider.dart';

import '../widgets/cast.dart';
import '../widgets/themed_annotated_region.dart';

class MovieDetailPage extends ConsumerStatefulWidget {
  const MovieDetailPage({
    super.key,
    required this.movie,
  });
  final Result movie;
  @override
  ConsumerState<MovieDetailPage> createState() => MovieDetailPageState();
}

class MovieDetailPageState extends ConsumerState<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<MovieDetail?> movie =
        ref.watch(singleMovieProvider(widget.movie));
    return Scaffold(
      body: ThemedAnnotatedRegion(
        child: switch (movie) {
          AsyncData(:final value) => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Positioned.fill(
                          child: CachedNetworkImage(
                            imageUrl: value?.backdropPath ?? "",
                            fit: BoxFit.fitHeight,
                            errorWidget: (_, __, ___) =>
                                Container(color: Colors.grey),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Theme.of(context).colorScheme.background,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    value?.name ??
                                        value?.title ??
                                        value?.originalTitle ??
                                        value?.originalName ??
                                        "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 24,
                                    child: Builder(
                                      builder: (context) {
                                        if (value?.runtime == null ||
                                            value?.releaseDate == null ||
                                            value?.genres == null) {
                                          return Text(
                                            value?.tagline ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                            textAlign: TextAlign.left,
                                          );
                                        } else {
                                          final year = value?.releaseDate!.year;
                                          final genre = value?.genres!.first;
                                          final minutes =
                                              (value?.runtime ?? 0) % 60;
                                          final hours =
                                              (value?.runtime ?? 0) ~/ 60;
                                          return Text(
                                            '$year • ${genre?.name} • ${hours}h ${minutes}m',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                            textAlign: TextAlign.left,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SafeArea(
                          minimum: EdgeInsets.only(top: 32.h, left: 16.w),
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              elevation: 5,
                            ),
                            child: const Icon(Icons.arrow_back),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Builder(builder: (context) {
                    if (value?.overview == null) {
                      return const SizedBox();
                    } else {
                      return Padding(
                        padding:
                            EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
                        child: Text(
                          value?.overview ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.justify,
                        ),
                      );
                    }
                  }),
                  Builder(
                    builder: (context) {
                      if (value?.casts == null) {
                        return const SizedBox();
                      } else {
                        return CastWidget(value?.casts ?? []);
                      }
                    },
                  ),
                  const SafeArea(
                    top: false,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          AsyncError(:final error) => Center(child: Text('Error: $error')),
          _ => Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
        },
      ),
    );
  }
}
