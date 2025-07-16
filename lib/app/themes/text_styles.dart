import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import 'fonts.dart';


class AppTextStyles {

  static const textField = TextStyle(
      fontFamily: AppFonts.poppins,

  );
  static const bodyBold = TextStyle(
      fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
  );

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

  static final welcome = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeMd,
    fontWeight: FontWeight.w600,
  );

  static final featureTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeSs,
    fontWeight: FontWeight.normal,
  );



  //Resume Builder
  static final infoHeader = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeSd,
    fontWeight: FontWeight.w600,
  );
  static final detailHeader = TextStyle(
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
  static final buttonLight = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeSm,
    fontWeight: FontWeight.w400,
    color: AppColors.blackLight,
  );
  static final welcomeCardFinal = TextStyle(
    color: AppColors.backgroundYellow,
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeLg,
    fontWeight: FontWeight.w400,
  );
  static final crackIt = TextStyle(
    color: AppColors.textGreen,
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeSm,
    fontWeight: FontWeight.w400,
  );




}
