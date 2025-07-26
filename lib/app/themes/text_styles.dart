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
        fontSize: context.fontSizeLG,
        color: color,
      );

  static TextStyle subheading(BuildContext context, {required Color color}) =>
      TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: context.fontSizeSM,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle welcome(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeMD,
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
    fontSize: context.fontSizeSM,
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
    fontSize: context.fontSizeSM,
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
    fontSize: context.fontSizeMD,
    fontWeight: FontWeight.w400,
  );

  static TextStyle crackIt(BuildContext context) => TextStyle(
    color: AppColors.textGreen,
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeSM,
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
    fontSize: context.fontSizeSM,
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
    color: AppColors.textGrey,
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
    fontSize: context.fontSizeSM,
  );
  static TextStyle labelStyleCategory(BuildContext context, bool isSelected) => TextStyle(
    // Added fontFamily
    fontFamily: AppFonts.poppins,
    color: isSelected ? AppColors.backgroundWhite : AppColors.blackLight,
    fontWeight: FontWeight.w500,
  );
  static TextStyle emptyStateHint(BuildContext context) => TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeSM,
    color: AppColors.textGrey,
  );


  static  TextStyle header(BuildContext context) =>   TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeLG,
    fontWeight: FontWeight.bold,
  );

  // Section title styles
  static  TextStyle sectionTitle (BuildContext context) =>  TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeMD,
    fontWeight: FontWeight.w600,
    color: AppColors.black87,
  );

  // Hint text styles

  static  TextStyle hintTextGrey (BuildContext context) =>  TextStyle(
    // Added fontFamily
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeSM,
    color: AppColors.textGrey,
  );

  // Button styles
  static  TextStyle buttonText (BuildContext context) =>  TextStyle(
    // Added fontFamily
    fontFamily: AppFonts.poppins,
    fontSize: context.fontSizeMD,
    fontWeight: FontWeight.w600,
  );

  // Chip styles
  static  TextStyle chipSelected (BuildContext context) =>  TextStyle(
    // Added fontFamily
    fontFamily: AppFonts.poppins,
    color: AppColors.white,
    fontWeight: FontWeight.w500,
  );

  static  TextStyle chipUnselected (BuildContext context) =>  TextStyle(
    // Added fontFamily
    fontFamily: AppFonts.poppins,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
  );

  // Filter chip styles
  static  TextStyle filterChipSelected (BuildContext context) =>  TextStyle(
    // Added fontFamily
    fontFamily: AppFonts.poppins,
    color: AppColors.backgroundGreen,
    fontWeight: FontWeight.w600,
  );

  static  TextStyle filterChipUnselected (BuildContext context) =>  TextStyle(
    // Added fontFamily
    fontFamily: AppFonts.poppins,
    color: AppColors.black,
    fontWeight: FontWeight.normal,
  );

  // Info text styles
  static TextStyle infoText (BuildContext context) =>  TextStyle(
    // Added fontFamily
    fontFamily: AppFonts.poppins,
    color: AppColors.blue700,
    fontWeight: FontWeight.w500,
  );

  // Custom chip style
  static  TextStyle customChipText (BuildContext context) =>  TextStyle(
    // Added fontFamily
    fontFamily: AppFonts.poppins,
    color: AppColors.textGreen,
  );

}