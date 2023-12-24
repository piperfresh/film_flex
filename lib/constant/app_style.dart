import 'dart:ui';

import 'package:filmflex/constant/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle{
  static var mediumMerriWeather = GoogleFonts.merriweather(
    fontWeight: FontWeight.w900,
    fontSize: 16,
    color: AppColors.primaryColor,
  );

  static var smallestMullish = GoogleFonts.mulish(
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: AppColors.secondaryColor,
  );

  static var smallMullish = GoogleFonts.mulish(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.blackColor,
  );


  static var mediumMullish = GoogleFonts.mulish(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: AppColors.blackColor,
  );

  static var bigMullish = GoogleFonts.mulish(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.blackColor,
  );
   static var biggestMerriWeather = GoogleFonts.merriweather(
    fontWeight: FontWeight.w900,
    fontSize: 16,
    color: AppColors.primaryColor,
  );

}