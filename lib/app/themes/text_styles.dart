import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../core/constants/colors.dart';

// Simplified AppTextStyles that extends the theme
class AppTextStyles {
  // Basic styles that extend theme styles
  static TextStyle textField(BuildContext context) =>
      context.textTheme.bodyLarge!.copyWith(
        fontSize: context.fontSizeSm,
      );

  static TextStyle bodyBold(BuildContext context) =>
      context.textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: context.fontSizeSx,
      );

  static TextStyle heading(BuildContext context, {required Color color}) =>
      context.textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: context.fontSizeMd,
        color: color,
      );

  static TextStyle subheading(BuildContext context, {required Color color}) =>
      context.textTheme.titleMedium!.copyWith(
        fontSize: context.fontSizeSm,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle welcome(BuildContext context) =>
      context.textTheme.headlineSmall!.copyWith(
        fontSize: context.fontSizeSx,
        fontWeight: FontWeight.w600,
      );

  static TextStyle featureTitle(BuildContext context) =>
      context.textTheme.titleMedium!.copyWith(
        fontSize: context.fontSizeSs,
        fontWeight: FontWeight.w500,
      );

  // Resume Builder
  static TextStyle infoHeader(BuildContext context) =>
      context.textTheme.headlineSmall!.copyWith(
        fontSize: context.fontSizeSd,
        fontWeight: FontWeight.w600,
      );

  static TextStyle infoSmallHeader(BuildContext context) =>
      context.textTheme.titleLarge!.copyWith(
        fontSize: context.fontSizeSx,
        fontWeight: FontWeight.w600,
      );

  static TextStyle detailHeader(BuildContext context) =>
      context.textTheme.titleMedium!.copyWith(
        fontSize: context.fontSizeSm,
        fontWeight: FontWeight.w500,
        color: AppColors.blackLight,
      );

  static TextStyle hintText(BuildContext context, {required Color color}) =>
      context.textTheme.bodyMedium!.copyWith(
        fontSize: context.fontSizeSs,
        fontWeight: FontWeight.w400,
        color: color,
      );

  // Buttons
  static TextStyle buttonLight(BuildContext context) =>
      context.textTheme.bodyLarge!.copyWith(
        fontSize: context.fontSizeSm,
        fontWeight: FontWeight.w400,
        color: AppColors.blackLight,
      );

  static TextStyle buttonSmall(BuildContext context) =>
      context.textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: context.fontSizeSs,
      );

  static TextStyle buttonWhiteText(BuildContext context) =>
      context.textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: context.fontSizeSs,
        color: AppColors.white,
      );

  // Special styles that are app-specific
  static TextStyle welcomeCardFinal(BuildContext context) =>
      context.textTheme.bodyLarge!.copyWith(
        color: AppColors.backgroundYellow,
        fontSize: context.fontSizeSx,
        fontWeight: FontWeight.w400,
      );

  // Modal bottom sheet
  static TextStyle subscriptionTitle(BuildContext context) =>
      context.textTheme.headlineSmall!.copyWith(
        color: AppColors.textYellow,
        fontSize: context.fontSizeSx,
        fontWeight: FontWeight.w600,
      );

  static TextStyle crackIt(BuildContext context) =>
      context.textTheme.bodyLarge!.copyWith(
        color: AppColors.textGreen,
        fontSize: context.fontSizeSm,
        fontWeight: FontWeight.w400,
      );

  // Bottom nav text style
  static TextStyle navTextStyle(BuildContext context, Color selectedColor) =>
      context.textTheme.labelMedium!.copyWith(
        fontSize: context.navLabelFontSize,
        color: selectedColor,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w500,
      );

  // Dialog box
  static TextStyle dialogBoxTitle(BuildContext context) =>
      context.textTheme.headlineSmall!.copyWith(
        color: AppColors.backgroundWhite,
        fontSize: context.fontSizeSx,
        fontWeight: FontWeight.bold,
      );

  static TextStyle dialogBoxSubTitle(BuildContext context) =>
      context.textTheme.bodyLarge!.copyWith(
        color: AppColors.backgroundWhite,
        fontSize: context.fontSizeSm,
        fontWeight: FontWeight.w400,
      );

  static TextStyle yes(BuildContext context) =>
      context.textTheme.bodyMedium!.copyWith(
        fontSize: context.fontSizeSs,
        color: AppColors.white
      );

  // Membership
  static TextStyle membershipSubTitle(BuildContext context) =>
      context.textTheme.titleMedium!.copyWith(
        fontSize: context.fontSizeSm,
        color: AppColors.buttonYellow,
        fontWeight: FontWeight.w600,
      );

  static TextStyle membershipDetail(BuildContext context) =>
      context.textTheme.bodyMedium!.copyWith(
        fontSize: context.fontSizeSs,
        color: AppColors.backgroundYellow,
        fontWeight: FontWeight.w400,
      );

  static TextStyle membershipOldMoney(BuildContext context) =>
      context.textTheme.bodyMedium!.copyWith(
        fontSize: context.fontSizeSs,
        decoration: TextDecoration.lineThrough,
        decorationColor: AppColors.backgroundYellow,
        color: AppColors.backgroundYellow,
        fontWeight: FontWeight.w400,
      );

  static TextStyle membershipNewMoney(BuildContext context) =>
      context.textTheme.bodyMedium!.copyWith(
        fontSize: context.fontSizeSs,
        color: AppColors.buttonYellow,
        fontWeight: FontWeight.w400,
      );

  // Interview template
  static TextStyle interviewTemplateJob(BuildContext context) =>
      context.textTheme.headlineSmall!.copyWith(
        fontSize: context.fontSizeSx,
        fontWeight: FontWeight.w600,
        color: AppColors.blackLight,
      );

  static TextStyle interviewTemplateJobDescription(BuildContext context) =>
      context.textTheme.bodyMedium!.copyWith(
        fontSize: context.fontSizeSs,
        color: AppColors.blackLight,
      );

  static TextStyle chipText(BuildContext context) =>
      context.textTheme.labelMedium!.copyWith(
        fontSize: context.fontSizeSs,
        color: AppColors.textGrey,
        fontWeight: FontWeight.w500,
      );

  static TextStyle noInterviewsFound(BuildContext context) =>
      context.textTheme.bodyLarge!.copyWith(
        fontSize: context.fontSizeSx,
        color: AppColors.textGrey,
        fontWeight: FontWeight.w500,
      );

  static TextStyle searchHint(BuildContext context) =>
      context.textTheme.bodyLarge!.copyWith(
        color: AppColors.searchHint,
        fontSize: context.fontSizeSm,
      );

  static TextStyle labelStyleCategory(BuildContext context, bool isSelected) =>
      context.textTheme.labelLarge!.copyWith(
        color: isSelected ? AppColors.backgroundWhite : AppColors.blackLight,
        fontWeight: FontWeight.w500,
      );

  static TextStyle emptyStateHint(BuildContext context) =>
      context.textTheme.bodyLarge!.copyWith(
        fontSize: context.fontSizeSm,
        color: AppColors.textGrey,
      );

  static TextStyle header(BuildContext context) =>
      context.textTheme.headlineMedium!.copyWith(
        fontSize: context.fontSizeMd,
        fontWeight: FontWeight.bold,
      );

  // Section title styles
  static TextStyle sectionTitle(BuildContext context) =>
      context.textTheme.headlineSmall!.copyWith(
        fontSize: context.fontSizeSx,
        fontWeight: FontWeight.w600,
        color: AppColors.black87,
      );

  // Hint text styles
  static TextStyle hintTextGrey(BuildContext context) =>
      context.textTheme.bodyLarge!.copyWith(
        fontSize: context.fontSizeSm,
        color: AppColors.textGrey,
      );

  static TextStyle hintTextColorful(BuildContext context, {required Color color}) =>
      context.textTheme.bodyMedium!.copyWith(
        fontSize: context.fontSizeSms,
        color: color,
      );

  // Button styles
  static TextStyle buttonText(BuildContext context) =>
      context.textTheme.labelLarge!.copyWith(
        fontSize: context.fontSizeSx,
        fontWeight: FontWeight.w600,
      );

  // Chip styles
  static TextStyle chipSelected(BuildContext context) =>
      context.textTheme.labelLarge!.copyWith(
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      );

  static TextStyle chipUnselected(BuildContext context) =>
      context.textTheme.labelLarge!.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
      );

  // Filter chip styles
  static TextStyle filterChipSelected(BuildContext context) =>
      context.textTheme.labelLarge!.copyWith(
        color: AppColors.backgroundGreen,
        fontWeight: FontWeight.w600,
      );

  static TextStyle filterChipUnselected(BuildContext context) =>
      context.textTheme.labelLarge!.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.normal,
      );

  // Info text styles
  static TextStyle infoText(BuildContext context) =>
      context.textTheme.bodyMedium!.copyWith(
        color: AppColors.blue700,
        fontWeight: FontWeight.w500,
      );

  static TextStyle snackBarText(BuildContext context) =>
      context.textTheme.bodyMedium!.copyWith(
        fontSize: context.fontSizeSms,
      );

  // Custom chip style
  static TextStyle customChipText(BuildContext context) =>
      context.textTheme.bodyMedium!.copyWith(
        color: AppColors.textGreen,
      );

  // Interview Reports styles
  static TextStyle interviewReportsTitle(BuildContext context) =>
      context.textTheme.headlineMedium!.copyWith(
        fontSize: context.fontSizeMd,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  // Date group headers: "TODAY", "YESTERDAY", etc.
  static TextStyle dateHeader(BuildContext context) =>
      context.textTheme.labelLarge!.copyWith(
        fontSize: context.fontSizeSm,
        fontWeight: FontWeight.w600,
        color: AppColors.darkPurple,
        letterSpacing: context.letterSpacing,
      );

  // Role title: "Flutter Developer (Dart Fundamentals)"
  static TextStyle roleTitle(BuildContext context) =>
      context.textTheme.titleMedium!.copyWith(
        fontSize: context.fontSizeSx,
        fontWeight: FontWeight.w500,
        color: AppColors.blackLight,
      );

  // Topics list: "Dart, OOP, SOLID..."
  static TextStyle topicSummary(BuildContext context) =>
      context.textTheme.bodyMedium!.copyWith(
        fontSize: context.fontSizeSms,
        fontWeight: FontWeight.w400,
        color: Colors.grey[700],
      );

  // Timestamp: "8 minutes ago"
  static TextStyle timestamp(BuildContext context) =>
      context.textTheme.bodySmall!.copyWith(
        fontSize: context.fontSizeSs,
        fontWeight: FontWeight.w400,
        color: Colors.grey[500],
      );

  // Interview Information styles
  static TextStyle interviewInformationTitle(BuildContext context) =>
      context.textTheme.titleMedium!.copyWith(
        color: AppColors.backgroundWhite,
        fontSize: context.fontSizeSm,
        fontWeight: FontWeight.w600,
      );

  static TextStyle interviewInformationSubTitle(BuildContext context) =>
      context.textTheme.bodyMedium!.copyWith(
        color: AppColors.backgroundWhite,
        fontSize: context.fontSizeSs,
        fontWeight: FontWeight.w400,
      );
}

// Extension for easy theme access (if not already defined elsewhere)
extension AppThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}