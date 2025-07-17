import 'package:flutter/material.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import '../../core/constants/colors.dart';
import 'fonts.dart';

class AppTextStyles {

  static TextStyle textField(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeSx,
  );

  static TextStyle bodyBold(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: context.fontSizeSx,
  );

  static TextStyle heading(BuildContext context, {required Color color}) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: context.fontSizeLg,
    color: color,
  );

  static TextStyle subheading(BuildContext context, {required Color color}) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeSm,
    fontWeight: FontWeight.w600,
    color: color,
  );

  static TextStyle welcome(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeMd,
    fontWeight: FontWeight.w600,
  );

  static TextStyle featureTitle(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeSs,
    fontWeight: FontWeight.normal,
  );

  // Resume Builder
  static TextStyle infoHeader(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeSd ,
    fontWeight: FontWeight.w600,
  );

  static TextStyle detailHeader(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize:  context.fontSizeSm ,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static TextStyle hintText(BuildContext context, {required Color color}) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize:  context.fontSizeSs ,
    fontWeight: FontWeight.w400,
    color: color,
  );

  // Buttons
  static TextStyle buttonLight(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize:  context.fontSizeSm ,
    fontWeight: FontWeight.w400,
    color: AppColors.blackLight,
  );

  static TextStyle welcomeCardFinal(BuildContext context) => TextStyle(
    color: AppColors.backgroundYellow,
    fontFamily: AppFonts.poppins,
    fontSize:  context.fontSizeLg ,
    fontWeight: FontWeight.w400,
  );

  static TextStyle crackIt(BuildContext context) => TextStyle(
    color: AppColors.textGreen,
    fontFamily: AppFonts.poppins,
    fontSize:  context.fontSizeSm ,
    fontWeight: FontWeight.w400,
  );
}