import 'package:flutter/material.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import '../../core/constants/colors.dart';
import 'fonts.dart';

class AppTextStyles {
  static TextStyle textField(BuildContext context) =>
      TextStyle(fontFamily: AppFonts.poppins, fontSize: context.fontSizeSx);

  static TextStyle bodyBold(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: context.fontSizeSx,
  );

  static TextStyle heading(BuildContext context, {required Color color}) =>
      TextStyle(
        fontFamily: AppFonts.poppins,
        fontWeight: FontWeight.w600,
        fontSize: context.fontSizeLg,
        color: color,
      );

  static TextStyle subheading(BuildContext context, {required Color color}) =>
      TextStyle(
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
    fontWeight: FontWeight.w500,
  );

  // Resume Builder
  static TextStyle infoHeader(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeSd,
    fontWeight: FontWeight.w600,
  );

  static TextStyle detailHeader(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeSm,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static TextStyle hintText(BuildContext context, {required Color color}) =>
      TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: context.fontSizeSs,
        fontWeight: FontWeight.w400,
        color: color,
      );

  // Buttons
  static TextStyle buttonLight(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeSm,
    fontWeight: FontWeight.w400,
    color: AppColors.blackLight,
  );

  static TextStyle buttonSmall(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: context.fontSizeSs,
  );

  static TextStyle welcomeCardFinal(BuildContext context) => TextStyle(
    color: AppColors.backgroundYellow,
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeMd,
    fontWeight: FontWeight.w400,
  );

  static TextStyle crackIt(BuildContext context) => TextStyle(
    color: AppColors.textGreen,
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeSm,
    fontWeight: FontWeight.w400,
  );

  //bottom nav text style
  static TextStyle navTextStyle(BuildContext context,Color selectedColor)=>TextStyle(
  fontFamily: AppFonts.poppins,
  fontSize: context.navLabelFontSize,
  color: selectedColor,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w500,
  );

  //membership
  static TextStyle membershipSubTitle(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeSm,
    color: AppColors.buttonYellow,
    fontWeight: FontWeight.w600,
  );


  //interview-template
  static TextStyle interviewTemplateJob(BuildContext context) => TextStyle(
    fontFamily:AppFonts.poppins,
    fontSize: context.fontSizeSx,
    fontWeight: FontWeight.w600,
    color: AppColors.blackLight,
  );
  static TextStyle interviewTemplateJobDescription(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeSs,
    color: AppColors.blackLight,
  );
  static TextStyle chipText(BuildContext context) => TextStyle(
    fontSize: context.fontSizeSs,
    fontFamily: AppFonts.poppins,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w500,
  );
  static TextStyle noInterviewsFound(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeSx,
    color: AppColors.textGrey,
    fontWeight: FontWeight.w500,
  );
  static TextStyle searchHint(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    color: AppColors.searchHint,
    fontSize: context.fontSizeSm,
  );
  static TextStyle labelStyleCategory(BuildContext context, bool isSelected) => TextStyle(
    color: isSelected ? AppColors.backgroundWhite : AppColors.blackLight,
    fontWeight: FontWeight.w500,
  );
  static TextStyle emptyStateHint(BuildContext context) => TextStyle(
    fontSize: context.fontSizeSm,
    color: AppColors.textGrey,
  );



}
