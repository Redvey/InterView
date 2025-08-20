import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../core/constants/colors.dart';
import 'fonts.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.purple),
      useMaterial3: true,
      fontFamily: AppFonts.poppins,
      primaryColor: AppColors.purple,

      textTheme: TextTheme(
        // Headline styles for large, prominent text
        headlineLarge: TextStyle(
          
          color: AppColors.black,
          fontSize: context.fontSizeMax,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          
          color: AppColors.black,
          fontSize: context.fontSizeLg,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          
          color: AppColors.black,
          fontSize: context.fontSizeMd,
          fontWeight: FontWeight.bold,
        ),
        // Body styles for standard text
        bodyLarge: TextStyle(
          
          color: AppColors.black,
          fontSize: context.fontSizeSx,
        ),
        bodyMedium: TextStyle(
          
          color: AppColors.black,
          fontSize: context.fontSizeSm,
        ),
        bodySmall: TextStyle(
          
          color: AppColors.black,
          fontSize: context.fontSizeSs,
        ),
        // Title styles for headings or labels
        titleLarge: TextStyle(
          
          color: AppColors.black,
          fontSize: context.fontSizeMd,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          
          color: AppColors.black,
          fontSize: context.fontSizeSd,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(
          
          color: AppColors.black,
          fontSize: context.fontSizeSx,
          fontWeight: FontWeight.bold,
        ),
        // Label styles for buttons and form fields
        labelLarge: TextStyle(
          
          color: AppColors.white,
          fontSize: context.fontSizeSx,

        ),
        labelMedium: TextStyle(
          
          color: AppColors.blackLight,
          fontSize: context.fontSizeSm,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          
          color: AppColors.blackLight,
          fontSize: context.fontSizeSs,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.all(context.md),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.borderRadiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.borderRadiusMd),
          borderSide: BorderSide(color: AppColors.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.borderRadiusMd),
          borderSide: BorderSide(color: AppColors.blackLight, width: context.borderWidthThin),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.borderRadiusMd),
          borderSide: BorderSide(color: AppColors.red, width: context.borderWidthDefault),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.borderRadiusMd),
          borderSide: BorderSide(color: AppColors.red, width: context.borderWidthDefault),
        ),
        labelStyle: TextStyle(
          
          color: AppColors.blackLight,
          fontSize: context.fontSizeSs,
        ),
        hintStyle: TextStyle(
          
          color: AppColors.grey400,
          fontSize: context.fontSizeSm,
        ),
      ),
    );
  }
}
