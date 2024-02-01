import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


import 'constant/app_colors.dart';

class FilmFlexTheme {
  /// Light text Mode
  static TextTheme lightTextTheme = TextTheme(
    bodySmall: GoogleFonts.mulish(
      fontWeight: FontWeight.w400,
      fontSize: 10.sp,
      color: AppColors.secondaryColor,
    ),
    bodyMedium: GoogleFonts.mulish(
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color: AppColors.blackColor,
    ),
    bodyLarge: GoogleFonts.mulish(
      fontWeight: FontWeight.w700,
      fontSize: 14.sp,
      color: AppColors.blackColor,
    ),
    displayMedium: GoogleFonts.mulish(
      fontWeight: FontWeight.w700,
      fontSize: 20.sp,
      color: AppColors.blackColor,
    ),
    displayLarge: GoogleFonts.merriweather(
      fontWeight: FontWeight.w900,
      fontSize: 16.sp,
      color: AppColors.primaryColor,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
   bodySmall: GoogleFonts.mulish(
    fontWeight: FontWeight.w400,
    fontSize: 10.sp,
    color: AppColors.white,
   ),
   bodyMedium: GoogleFonts.mulish(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: AppColors.white,
   ),
   bodyLarge: GoogleFonts.mulish(
    fontWeight: FontWeight.w700,
    fontSize: 14.sp,
    color: AppColors.white,
   ),
   displayMedium: GoogleFonts.mulish(
    fontWeight: FontWeight.w700,
    fontSize: 20.sp,
    color: AppColors.white,
   ),
   displayLarge: GoogleFonts.merriweather(
    fontWeight: FontWeight.w900,
    fontSize: 16.sp,
    color: AppColors.white,
   ),
  );

  static ThemeData lightTheme(){
   return ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white, backgroundColor: Colors.white),
    textTheme: lightTextTheme,
   );
  }

  static ThemeData darkTheme(){
   return ThemeData(
    brightness: Brightness.dark,
    textTheme: darkTextTheme,
   );
  }
}
