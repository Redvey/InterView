import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:interview/core/utils/extensions/responsive_extension.dart';

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


  // Padding and margin sizes
  static double md(BuildContext context) => 16.0 * _getScaleFactor(context);
  static double mx(BuildContext context) => 12.0 * _getScaleFactor(context);
  static double mxs(BuildContext context) => 8.0 * _getScaleFactor(context);
  static double mxW(BuildContext context) => 12.0 * _getScaleFactor(context);
  static double mdV(BuildContext context) => 16.0 * _getHeightScaleFactor(context);
  static double lg(BuildContext context) => 24.0 * _getScaleFactor(context);
  static double lgV(BuildContext context) => 24.0 * _getHeightScaleFactor(context);
  static double lgAnim(BuildContext context) => 80.0 * _getHeightScaleFactor(context);
  static double xl(BuildContext context) => 60.0 * _getScaleFactor(context);
  static double xlV(BuildContext context) => 60.0 * _getHeightScaleFactor(context);

  // Icons size
  static double iconSize(BuildContext context) => 30.0 * _getScaleFactor(context);
  static double iconSizeSm(BuildContext context) => 24.0 * _getScaleFactor(context);

  // Blur radius & spread radius
  static double welcomeBlur(BuildContext context) => 40.0 * _getScaleFactor(context);
  static double welcomeSpread(BuildContext context) => 2.0 * _getScaleFactor(context);
  static double glowBlur(BuildContext context) => 100.0 * _getScaleFactor(context);
  static double glowSpread(BuildContext context) => 10.0 * _getScaleFactor(context);
  static double metaBlur(BuildContext context) => 30.0 * _getScaleFactor(context);

  // Glow bar sizes
  static double glowH(BuildContext context) => 6.0 * _getHeightScaleFactor(context);
  static double glowBorderRadius(BuildContext context) => 3.0 * _getHeightScaleFactor(context);
  static double glowW(BuildContext context) => 60.0 * _getWidthScaleFactor(context);
  static double glowB(BuildContext context) => 3.0 * _getScaleFactor(context);

  // Font sizes
  static double fontSizeSten(BuildContext context) => 10.0 * _getScaleFactor(context);
  static double fontSizeSs(BuildContext context) => 12.0 * _getScaleFactor(context);
  static double fontSizeSms(BuildContext context) => 13.0 * _getScaleFactor(context);
  static double fontSizeSm(BuildContext context) => 14.0 * _getScaleFactor(context);
  static double fontSizeSx(BuildContext context) => 16.0 * _getScaleFactor(context);
  static double fontSizeSd(BuildContext context) => 18.0 * _getScaleFactor(context);
  static double fontSizeMd(BuildContext context) => 20.0 * _getScaleFactor(context);
  static double fontSizeLg(BuildContext context) => 22.0 * _getScaleFactor(context);
  static double letterSpacing(BuildContext context) => 0.5 * _getScaleFactor(context);

  // Button sizes
  static double buttonHeight(BuildContext context) => 18.0 * _getHeightScaleFactor(context);
  static double buttonHeightSmall(BuildContext context) => 10.0 * _getHeightScaleFactor(context);
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
  static double fieldLabelSpacing(BuildContext context) => 4.0 * _getHeightScaleFactor(context);
  static double defaultSpaceH(BuildContext context) => 12.0 * _getHeightScaleFactor(context);
  static double spaceBtwItemsH(BuildContext context) => 16.0 * _getHeightScaleFactor(context);
  static double spaceBtwFields(BuildContext context) => 20.0 * _getHeightScaleFactor(context);
  static double spaceBtwSections(BuildContext context) => 48.0 * _getHeightScaleFactor(context);

  //Profile Screen Items
  static double profileHeight(BuildContext context) => 38.0 * _getHeightScaleFactor(context);
  static double profileWidth(BuildContext context) => 38.0 * _getWidthScaleFactor(context);

  // === BOTTOM NAVIGATION SPECIFIC SIZES ===

  // Bottom nav container
  static double bottomNavHeight(BuildContext context) => 70.0 * _getHeightScaleFactor(context);
  static double bottomNavBottomPadding(BuildContext context) => 40.0 * _getHeightScaleFactor(context);
  static double bottomNavRadius(BuildContext context) => 60.0 * _getScaleFactor(context);
  static double bottomWidth(BuildContext context) => 2.0 * _getScaleFactor(context);
  static double bottomNavHorizontalPadding(BuildContext context) => 16.0 * _getWidthScaleFactor(context);

  // Border widths section
  static double borderWidthThin(BuildContext context) => 1.0 * _getScaleFactor(context);
  static double borderWidthDefault(BuildContext context) => 2.0 * _getScaleFactor(context);
  static double borderWidthThick(BuildContext context) => 3.0 * _getScaleFactor(context);

  // Bottom nav shadow
  static double bottomNavShadowBlur(BuildContext context) => 20.0 * _getScaleFactor(context);
  static double bottomNavShadowOffsetY(BuildContext context) => 8.0 * _getHeightScaleFactor(context);
  static double bottomNavShadowAlpha(BuildContext context) => 26 * _getScaleFactor(context);

  // Nav icon container
  static double navIconPaddingHorizontal(BuildContext context) => 12.0 * _getWidthScaleFactor(context);
  static double navIconPaddingVertical(BuildContext context) => 8.0 * _getHeightScaleFactor(context);
  static double navIconBorderRadius(BuildContext context) => 24.0 * _getScaleFactor(context);

  // Nav icon sizes
  static double navIconSizeSelected(BuildContext context) => 28.0 * _getScaleFactor(context);
  static double navIconSizeUnselected(BuildContext context) => 24.0 * _getScaleFactor(context);

  // Nav label
  static double navLabelPaddingLeft(BuildContext context) => 8.0 * _getWidthScaleFactor(context);
  static double navLabelFontSize(BuildContext context) => 14.0 * _getScaleFactor(context);

  // Animation durations (in milliseconds)
  static int navAnimationDuration = 300;
  static int maxSelection = 12;
  static int maxLinesEmailBody = 10;

  // === NEW ADDITIONS FOR LIQUID MENU OVERLAY ===

  // Profile button animations
  static double profileTranslateX(BuildContext context) => 70.0 * _getWidthScaleFactor(context);

  // Close button properties
  static double closeButtonHideOffset(BuildContext context) => 50.0 * _getWidthScaleFactor(context);
  static int closeButtonOpacity = 51; // Alpha value for Colors.white.withAlpha(51)
  static double closeButtonIconSize(BuildContext context) => 24.0 * _getScaleFactor(context);

  // User greeting animation properties
  static int userGreetingAnimationDuration = 800; // milliseconds
  static double userGreetingTranslateX(BuildContext context) => 300.0 * _getWidthScaleFactor(context);
  static double userGreetingPadding(BuildContext context) => 40.0 * _getScaleFactor(context);
  static double userAvatarRadius(BuildContext context) => 60.0 * _getScaleFactor(context);

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
  static double borderRadiusLx(BuildContext context) => 12.0 * _getScaleFactor(context);
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


  //mock-interview
  static double recentSearches(BuildContext context) => 40.0 * _getHeightScaleFactor(context);
  //success screen
  static double lottieHeight(BuildContext context) => 250.0 * _getHeightScaleFactor(context);
  static double lottieWidth(BuildContext context) => 250.0 * _getWidthScaleFactor(context);

  static double xs(BuildContext context) => 4.0 * _getScaleFactor(context);
  static double sm(BuildContext context) => 8.0 * _getScaleFactor(context);
  static double xxl(BuildContext context) => 24.0 * _getScaleFactor(context);
  static double xxxl(BuildContext context) => 32.0 * _getScaleFactor(context);

  // Padding
  static double paddingXS(BuildContext context) => 4.0 * _getScaleFactor(context);
  static double paddingSM(BuildContext context) => 8.0 * _getScaleFactor(context);
  static double paddingMD(BuildContext context) => 12.0 * _getScaleFactor(context);
  static double paddingLG(BuildContext context) => 16.0 * _getScaleFactor(context);
  static double paddingXL(BuildContext context) => 20.0 * _getScaleFactor(context);
  static double paddingXXL(BuildContext context) => 24.0 * _getScaleFactor(context);

  // Border Radius
  static double radiusXS(BuildContext context) => 2.0 * _getScaleFactor(context);
  static double radiusSM(BuildContext context) => 8.0 * _getScaleFactor(context);
  static double radiusMD(BuildContext context) => 12.0 * _getScaleFactor(context);
  static double radiusLG(BuildContext context) => 20.0 * _getScaleFactor(context);
  static double radiusXL(BuildContext context) => 25.0 * _getScaleFactor(context);

  // Heights & Widths (choose appropriate scale factor)
  static double createButtonHeight(BuildContext context) => 50.0 * _getHeightScaleFactor(context);
  static double handleWidth(BuildContext context) => 40.0 * _getWidthScaleFactor(context);
  static double handleHeight(BuildContext context) => 4.0 * _getHeightScaleFactor(context);


  // textFieldMaxLines is not a size, it's an integer property, no scaling needed
  static const int textFieldMaxLines = 4;
  static double iconSizeSM(BuildContext context) => 18.0 * _getScaleFactor(context);
  static double iconSizeSX(BuildContext context) => 16.0 * _getScaleFactor(context);
  static double iconSizeMD(BuildContext context) => 20.0 * _getScaleFactor(context);

  // Sheet Sizes (these are usually ratios, not fixed sizes to scale)
  static const double sheetInitialSize = 0.9;
  static const double sheetMinSize = 0.5;
  static const double sheetMaxSize = 0.95;

  //cold mail
  //file attachment
  static double attachedFileItemHeight(BuildContext context) => 100.0 * _getHeightScaleFactor(context);
  static double attachedFileItemWidth(BuildContext context) => 140.0 * _getWidthScaleFactor(context);
  static double emailBodyHeight(BuildContext context) => 320.0 * _getHeightScaleFactor(context);





  // Extra Spacing
  static double extraSpacingForButton(BuildContext context) => 100.0 * _getHeightScaleFactor(context);



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