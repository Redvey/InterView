import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  // Padding and margin sizes
  static double md = 16.w;
  static double mdV = 16.h;
  static double lg = 24.w;
  static double lgV = 24.h;
  static double xl = 60.w;
  static double xlV = 60.h;

  // Icons size
  static double star = 28.sp;

  // Blur radius & spread radius
  static double welcomeBlur = 40.r;
  static double welcomeSpread = 2.r;
  static double glowBlur = 100.r;
  static double glowSpread = 25.r;

  // Glow bar sizes
  static double glowH = 6.h;
  static double glowW = 60.w;
  static double glowB = 3.r;

  // Font sizes
  static double fontSizeSs = 12.sp;
  static double fontSizeSm = 14.sp;
  static double fontSizeSx = 16.sp;
  static double fontSizeSd = 18.sp;
  static double fontSizeMd = 20.sp;
  static double fontSizeLg = 22.sp;

  // Button sizes
  static double buttonHeight = 18.h;
  static double buttonRadius = 12.r;
  static double buttonWidth = 120.w;
  static double buttonElevation = 4.r;

  // Image sizes
  static double imageThumbSize = 80.w;

  // Offsets
  static final double shadowOffsetY = -10.0.h;
  static final double zero = 0.h;

  // Horizontal spacing
  static double spaceLess = 10.w;
  static double defaultSpace = 12.w;
  static double spaceBtwItems = 16.w;
  static double headSubhead = 4.w;

  // Vertical spacing
  static double spaceBtwFields = 20.h;
  static double spaceBtwSections = 48.h;

  // Combined spacing
  static EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: lg).copyWith(top: lgV, bottom: spaceBtwSections);

  // Border radius
  static double borderRadiusSm = 4.r;
  static double borderRadiusMd = 8.r;
  static double borderRadiusLg = 24.r;

  // Divider
  static double dividerHeight = 1.h;

  // Product item dimensions
  static double productImageSize = 120.w;
  static double productImageRadius = 16.r;
  static double productItemHeight = 160.h;

  // Input field
  static double inputFieldRadius = 12.r;
  static double spaceBtwInputFields = 16.h;

  // Welcome card
  static double adCard = 200.h;
  static double featureCard = 100.h;

  // Star Rating
  static double starSpacing = 4.w;
  static int maxStars = 5;
}
