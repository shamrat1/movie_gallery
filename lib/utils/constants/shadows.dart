import 'package:flutter/material.dart';
import 'package:movie_gallery/utils/constants/colors.dart';

class TShadows {
  static List<BoxShadow> primaryBoxShadow = [
    BoxShadow(
      color: TColors.primaryShadowColor.withOpacity(.1),
      offset: const Offset(0, 3),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];
}
