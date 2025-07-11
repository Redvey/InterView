import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import 'fonts.dart';


class AppTextStyles {
  static  heading({required Color color}) =>  TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeLg,
    fontWeight: FontWeight.w600,
    color: color,
  );

  static  subheading({required Color color}) =>  TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeSm,
    fontWeight: FontWeight.w600,
      color: color,
  );

  static const welcome = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeMd,
    fontWeight: FontWeight.normal,
  );



  //Resume Builder
  static const infoHeader = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeSd,
    fontWeight: FontWeight.w600,
  );
  static const detailHeader = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeSm,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
  static TextStyle hintText({required Color color}) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeSs,
    fontWeight: FontWeight.w400,
    color: color,
  );

  //buttons
  static const buttonLight = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeSm,
    fontWeight: FontWeight.w400,
    color: AppColors.blackLight,
  );




}
