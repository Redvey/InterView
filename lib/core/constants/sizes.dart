import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:interview/core/extensions/responsive_extension.dart';

class AppSizes {
  // iPhone 16 width as reference
  static const double baseWidth = 393.0;
  static const double baseHeight = 852.0;

  // Get scale factors
  static double _getWidthScaleFactor(BuildContext context) {
    return MediaQuery.of(context).size.width / baseWidth;
  }

  static double _getHeightScaleFactor(BuildContext context) {
    return MediaQuery.of(context).size.height / baseHeight;
  }

  static double _getScaleFactor(BuildContext context) {
    // Use the smaller scale factor to ensure content fits on screen
    return math.min(_getWidthScaleFactor(context), _getHeightScaleFactor(context));
  }
// ignore: unused_element
  static double _getMinScaleFactor(BuildContext context) {
    // Use minimum scale factor to ensure content fits on screen
    return math.min(_getWidthScaleFactor(context), _getHeightScaleFactor(context));
  }

  // ignore: unused_element
  static double _getMaxScaleFactor(BuildContext context) {
    // Use maximum scale factor for elements that should fill available space
    return math.max(_getWidthScaleFactor(context), _getHeightScaleFactor(context));
  }

  // ignore: unused_element
  static double _getAverageScaleFactor(BuildContext context) {
    // Use average scale factor for balanced scaling
    return (_getWidthScaleFactor(context) + _getHeightScaleFactor(context)) / 2;
  }

  // Padding and margin sizes
  static double md(BuildContext context) => 16.0 * _getScaleFactor(context);
  static double mdV(BuildContext context) => 16.0 * _getHeightScaleFactor(context);
  static double lg(BuildContext context) => 24.0 * _getScaleFactor(context);
  static double lgV(BuildContext context) => 24.0 * _getHeightScaleFactor(context);
  static double lgAnim(BuildContext context) => 80.0 * _getHeightScaleFactor(context);
  static double xl(BuildContext context) => 60.0 * _getScaleFactor(context);
  static double xlV(BuildContext context) => 60.0 * _getHeightScaleFactor(context);

  // Icons size
  static double iconSize(BuildContext context) => 28.0 * _getScaleFactor(context);

  // Blur radius & spread radius
  static double welcomeBlur(BuildContext context) => 40.0 * _getScaleFactor(context);
  static double welcomeSpread(BuildContext context) => 2.0 * _getScaleFactor(context);
  static double glowBlur(BuildContext context) => 100.0 * _getScaleFactor(context);
  static double glowSpread(BuildContext context) => 25.0 * _getScaleFactor(context);

  // Glow bar sizes
  static double glowH(BuildContext context) => 6.0 * _getHeightScaleFactor(context);
  static double glowW(BuildContext context) => 60.0 * _getWidthScaleFactor(context);
  static double glowB(BuildContext context) => 3.0 * _getScaleFactor(context);

  // Font sizes
  static double fontSizeSs(BuildContext context) => 12.0 * _getScaleFactor(context);
  static double fontSizeSm(BuildContext context) => 14.0 * _getScaleFactor(context);
  static double fontSizeSx(BuildContext context) => 16.0 * _getScaleFactor(context);
  static double fontSizeSd(BuildContext context) => 18.0 * _getScaleFactor(context);
  static double fontSizeMd(BuildContext context) => 20.0 * _getScaleFactor(context);
  static double fontSizeLg(BuildContext context) => 22.0 * _getScaleFactor(context);

  // Button sizes
  static double buttonHeight(BuildContext context) => 18.0 * _getHeightScaleFactor(context);
  static double buttonRadius(BuildContext context) => 12.0 * _getScaleFactor(context);
  static double circularButtonRadius(BuildContext context) => 30.0 * _getScaleFactor(context);
  static double buttonWidth(BuildContext context) => 120.0 * _getWidthScaleFactor(context);
  static double buttonElevation(BuildContext context) => 4.0 * _getScaleFactor(context);

  // Image sizes
  static double imageThumbSize(BuildContext context) => 80.0 * _getWidthScaleFactor(context);

  // Offsets
  static double shadowOffsetY(BuildContext context) => -10.0 * _getHeightScaleFactor(context);
  static double shadowOffsetY2(BuildContext context) => 1.0 * _getHeightScaleFactor(context);
  static double shadowOffsetX2(BuildContext context) => 2.0 * _getWidthScaleFactor(context);
  static double zero(BuildContext context) => 0.0;

  // Horizontal spacing
  static double spaceLess(BuildContext context) => 10.0 * _getWidthScaleFactor(context);
  static double defaultSpace(BuildContext context) => 12.0 * _getWidthScaleFactor(context);
  static double spaceBtwItems(BuildContext context) => 16.0 * _getWidthScaleFactor(context);
  static double headSubhead(BuildContext context) => 4.0 * _getWidthScaleFactor(context);

  // Vertical spacing
  static double spaceLessH(BuildContext context) => 10.0 * _getHeightScaleFactor(context);
  static double defaultSpaceH(BuildContext context) => 12.0 * _getHeightScaleFactor(context);
  static double spaceBtwItemsH(BuildContext context) => 16.0 * _getHeightScaleFactor(context);
  static double spaceBtwFields(BuildContext context) => 20.0 * _getHeightScaleFactor(context);
  static double spaceBtwSections(BuildContext context) => 48.0 * _getHeightScaleFactor(context);

  // Combined spacing
  static EdgeInsets screenPadding(BuildContext context) {
    // EdgeInsets safePadding = MediaQuery.of(context).padding;
    return EdgeInsets.symmetric(horizontal: context.lg).copyWith(
        top: context.lgV,
        bottom: spaceBtwSections(context)
    );
  }

  // Missing EdgeInsets methods
  static EdgeInsets defaultPadding(BuildContext context) {
    return EdgeInsets.all(md(context));
  }

  static EdgeInsets horizontalPadding(BuildContext context) {
    return EdgeInsets.symmetric(horizontal: md(context));
  }

  static EdgeInsets verticalPadding(BuildContext context) {
    return EdgeInsets.symmetric(vertical: mdV(context));
  }

  // Border radius
  static double borderRadiusSm(BuildContext context) => 4.0 * _getScaleFactor(context);
  static double borderRadiusMd(BuildContext context) => 8.0 * _getScaleFactor(context);
  static double borderRadiusLg(BuildContext context) => 24.0 * _getScaleFactor(context);
  static double sheetRadius(BuildContext context) => 24.0 * _getScaleFactor(context);

  // Divider
  static double dividerHeight(BuildContext context) => 1.0 * _getHeightScaleFactor(context);

  // Product item dimensions
  static double productImageSize(BuildContext context) => 120.0 * _getWidthScaleFactor(context);
  static double productImageRadius(BuildContext context) => 16.0 * _getScaleFactor(context);
  static double productItemHeight(BuildContext context) => 160.0 * _getHeightScaleFactor(context);

  // Input field
  static double inputFieldRadius(BuildContext context) => 12.0 * _getScaleFactor(context);
  static double spaceBtwInputFields(BuildContext context) => 16.0 * _getHeightScaleFactor(context);

  // Welcome card
  static double adCard(BuildContext context) => 200.0 * _getHeightScaleFactor(context);
  static double featureCard(BuildContext context) => 100.0 * _getHeightScaleFactor(context);

  // Star Rating
  static double starSpacing(BuildContext context) => 4.0 * _getWidthScaleFactor(context);
  static int maxStars = 5;

  // Helper methods for responsive design
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }
}
