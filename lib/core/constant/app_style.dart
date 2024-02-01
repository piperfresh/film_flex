
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyle {
  static var mediumMerriWeather = GoogleFonts.merriweather(
    fontWeight: FontWeight.w900,
    fontSize: 16.sp,
    color: AppColors.primaryColor,
  );

  static var smallestMullish = GoogleFonts.mulish(
    fontWeight: FontWeight.w400,
    fontSize: 10.sp,
    color: AppColors.secondaryColor,
  );

  static var smallMullish = GoogleFonts.mulish(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: AppColors.blackColor,
  );


  static var mediumMullish = GoogleFonts.mulish(
    fontWeight: FontWeight.w700,
    fontSize: 14.sp,
    color: AppColors.blackColor,
  );

  static var bigMullish = GoogleFonts.mulish(
    fontWeight: FontWeight.w700,
    fontSize: 20.sp,
    color: AppColors.blackColor,
  );
  static var biggestMerriWeather = GoogleFonts.merriweather(
    fontWeight: FontWeight.w900,
    fontSize: 16.sp,
    color: AppColors.primaryColor,
  );
}