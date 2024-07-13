import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/movie_details_response.dart';
import '../widgets/cast.dart';
import '../widgets/themed_annotated_region.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.detail});

  final MovieDetail detail;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return MovieContent(widget.detail);
  }
}

class MovieContent extends StatelessWidget {
  final MovieDetail _movieDetailUiModel;

  const MovieContent(this._movieDetailUiModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ThemedAnnotatedRegion(
        child: SingleChildScrollView(
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
                        imageUrl: _movieDetailUiModel.backdropPath ?? "",
                        fit: BoxFit.fitHeight,
                        errorWidget: (_, __, ___) =>
                            Container(color: Colors.grey),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
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
                                _movieDetailUiModel.title ??
                                    _movieDetailUiModel.originalTitle ??
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
                                    if (_movieDetailUiModel.runtime == null ||
                                        _movieDetailUiModel.releaseDate ==
                                            null ||
                                        _movieDetailUiModel.genres == null) {
                                      return const Text("");
                                    } else {
                                      final year =
                                          _movieDetailUiModel.releaseDate!.year;
                                      final genre =
                                          _movieDetailUiModel.genres!.first;
                                      final minutes =
                                          _movieDetailUiModel.runtime! % 60;
                                      final hours =
                                          _movieDetailUiModel.runtime! ~/ 60;
                                      return Text(
                                        '$year • ${genre.name} • ${hours}h ${minutes}m',
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
                      minimum: const EdgeInsets.only(top: 32),
                      child: BackButton(
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
              Builder(builder: (context) {
                if (_movieDetailUiModel.overview == null) {
                  return const SizedBox();
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      _movieDetailUiModel.overview!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    ),
                  );
                }
              }),
              Builder(
                builder: (context) {
                  if (_movieDetailUiModel.casts == null) {
                    return const SizedBox();
                  } else {
                    return CastWidget(_movieDetailUiModel.casts!);
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
      ),
    );
  }
}
