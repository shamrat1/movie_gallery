import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart';

/// Custom Class for Light & Dark Text Themes
class TTextTheme {
  TTextTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
        fontSize: 32.sp, fontWeight: FontWeight.bold, color: TColors.dark),
    headlineMedium: GoogleFonts.poppins(
        fontSize: 24.sp, fontWeight: FontWeight.w600, color: TColors.dark),
    headlineSmall: GoogleFonts.poppins(
        fontSize: 18.sp, fontWeight: FontWeight.w600, color: TColors.dark),
    titleLarge: GoogleFonts.poppins(
        fontSize: 16.sp, fontWeight: FontWeight.w600, color: TColors.dark),
    titleMedium: GoogleFonts.poppins(
        fontSize: 16.sp, fontWeight: FontWeight.w500, color: TColors.dark),
    titleSmall: GoogleFonts.poppins(
        fontSize: 16.sp, fontWeight: FontWeight.w400, color: TColors.dark),
    bodyLarge: GoogleFonts.poppins(
        fontSize: 14.sp, fontWeight: FontWeight.w500, color: TColors.dark),
    bodyMedium: GoogleFonts.poppins(
        fontSize: 14.sp, fontWeight: FontWeight.normal, color: TColors.dark),
    bodySmall: GoogleFonts.poppins(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: TColors.dark.withOpacity(0.5)),
    labelLarge: GoogleFonts.poppins(
        fontSize: 12.sp, fontWeight: FontWeight.normal, color: TColors.dark),
    labelMedium: GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: TColors.dark.withOpacity(0.5)),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
        fontSize: 32.sp, fontWeight: FontWeight.bold, color: TColors.light),
    headlineMedium: GoogleFonts.poppins(
        fontSize: 24.sp, fontWeight: FontWeight.w600, color: TColors.light),
    headlineSmall: GoogleFonts.poppins(
        fontSize: 18.sp, fontWeight: FontWeight.w600, color: TColors.light),
    titleLarge: GoogleFonts.poppins(
        fontSize: 16.sp, fontWeight: FontWeight.w600, color: TColors.light),
    titleMedium: GoogleFonts.poppins(
        fontSize: 16.sp, fontWeight: FontWeight.w500, color: TColors.light),
    titleSmall: GoogleFonts.poppins(
        fontSize: 16.sp, fontWeight: FontWeight.w400, color: TColors.light),
    bodyLarge: GoogleFonts.poppins(
        fontSize: 14.sp, fontWeight: FontWeight.w500, color: TColors.light),
    bodyMedium: GoogleFonts.poppins(
        fontSize: 14.sp, fontWeight: FontWeight.normal, color: TColors.light),
    bodySmall: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: TColors.light.withOpacity(0.5)),
    labelLarge: GoogleFonts.poppins(
        fontSize: 12.sp, fontWeight: FontWeight.normal, color: TColors.light),
    labelMedium: GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: TColors.light.withOpacity(0.5)),
  );
}
