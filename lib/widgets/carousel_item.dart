import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_gallery/models/home_response.dart';
import 'package:movie_gallery/screens/movie_details.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({super.key, this.result});
  final Result? result;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => MovieDetailPage(movie: result!))),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10.h),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    result?.backdropPath ?? "", //Images stored in assets folder
                fit: BoxFit.cover,
                errorWidget: (context, error, stackTrace) => Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(16.w),
                  child: Text(error.toString()),
                ),
              ),
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
                      Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.8),
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
                      result?.title ??
                          result?.originalTitle ??
                          result?.originalName ??
                          "",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      (result?.overview ?? result?.originalTitle ?? "")
                          .substring(0, 50),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
