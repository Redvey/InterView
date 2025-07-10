import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';
import 'fonts.dart';


class AppTextStyles {
  static const heading = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeLg,
    fontWeight: FontWeight.w600,
    color: AppColors.textRedBg,
  );

  static const subheading = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: AppSizes.fontSizeSm,
    fontWeight: FontWeight.w600,
      color: AppColors.textRed,
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




}
