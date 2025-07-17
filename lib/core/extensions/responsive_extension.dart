import 'package:flutter/material.dart';
import '../../app/themes/text_styles.dart';
import '../constants/sizes.dart';


extension ResponsiveContext on BuildContext {

  // === SIZES ===

  // Padding and margins
  double get md => AppSizes.md(this);
  double get mdV => AppSizes.mdV(this);
  double get lg => AppSizes.lg(this);
  double get lgV => AppSizes.lgV(this);
  double get xl => AppSizes.xl(this);
  double get xlV => AppSizes.xlV(this);

  // Icons
  double get iconSize => AppSizes.iconSize(this);

  // Blur & spread
  double get welcomeBlur => AppSizes.welcomeBlur(this);
  double get welcomeSpread => AppSizes.welcomeSpread(this);
  double get glowBlur => AppSizes.glowBlur(this);
  double get glowSpread => AppSizes.glowSpread(this);

  // Glow bars
  double get glowH => AppSizes.glowH(this);
  double get glowW => AppSizes.glowW(this);
  double get glowB => AppSizes.glowB(this);

  // Font sizes
  double get fontSizeSs => AppSizes.fontSizeSs(this);
  double get fontSizeSm => AppSizes.fontSizeSm(this);
  double get fontSizeSx => AppSizes.fontSizeSx(this);
  double get fontSizeSd => AppSizes.fontSizeSd(this);
  double get fontSizeMd => AppSizes.fontSizeMd(this);
  double get fontSizeLg => AppSizes.fontSizeLg(this);

  // Buttons
  double get buttonHeight => AppSizes.buttonHeight(this);
  double get buttonRadius => AppSizes.buttonRadius(this);
  double get buttonWidth => AppSizes.buttonWidth(this);
  double get buttonElevation => AppSizes.buttonElevation(this);

  // Images
  double get imageThumbSize => AppSizes.imageThumbSize(this);

  // Offsets
  double get shadowOffsetY => AppSizes.shadowOffsetY(this);
  double get shadowOffsetY2 => AppSizes.shadowOffsetY2(this);
  double get shadowOffsetX2 => AppSizes.shadowOffsetX2(this);
  double get zero => AppSizes.zero(this);

  // Horizontal spacing
  double get spaceLess => AppSizes.spaceLess(this);
  double get defaultSpace => AppSizes.defaultSpace(this);
  double get spaceBtwItems => AppSizes.spaceBtwItems(this);
  double get headSubhead => AppSizes.headSubhead(this);

  // Vertical spacing
  double get spaceLessH => AppSizes.spaceLessH(this);
  double get defaultSpaceH => AppSizes.defaultSpaceH(this);
  double get spaceBtwItemsH => AppSizes.spaceBtwItemsH(this);
  double get spaceBtwFields => AppSizes.spaceBtwFields(this);
  double get spaceBtwSections => AppSizes.spaceBtwSections(this);

  // Border radius
  double get borderRadiusSm => AppSizes.borderRadiusSm(this);
  double get borderRadiusMd => AppSizes.borderRadiusMd(this);
  double get borderRadiusLg => AppSizes.borderRadiusLg(this);
  double get sheetRadius => AppSizes.sheetRadius(this);

  // Divider
  double get dividerHeight => AppSizes.dividerHeight(this);

  // Product items
  double get productImageSize => AppSizes.productImageSize(this);
  double get productImageRadius => AppSizes.productImageRadius(this);
  double get productItemHeight => AppSizes.productItemHeight(this);

  // Input fields
  double get inputFieldRadius => AppSizes.inputFieldRadius(this);
  double get spaceBtwInputFields => AppSizes.spaceBtwInputFields(this);

  // Welcome cards
  double get adCard => AppSizes.adCard(this);
  double get featureCard => AppSizes.featureCard(this);

  // Star rating
  double get starSpacing => AppSizes.starSpacing(this);
  int get maxStars => AppSizes.maxStars;

  // === EDGE INSETS ===
  EdgeInsets get screenPadding => AppSizes.screenPadding(this);
  EdgeInsets get defaultPadding => AppSizes.defaultPadding(this);
  EdgeInsets get horizontalPadding => AppSizes.horizontalPadding(this);
  EdgeInsets get verticalPadding => AppSizes.verticalPadding(this);

  // === TEXT STYLES ===
  TextStyle get textFieldStyle => AppTextStyles.textField(this);
  TextStyle get bodyBoldStyle => AppTextStyles.bodyBold(this);
  TextStyle headingStyle({required Color color}) => AppTextStyles.heading(this, color: color);
  TextStyle subheadingStyle({required Color color}) => AppTextStyles.subheading(this, color: color);
  TextStyle get welcomeStyle => AppTextStyles.welcome(this);
  TextStyle get featureTitleStyle => AppTextStyles.featureTitle(this);
  TextStyle get infoHeaderStyle => AppTextStyles.infoHeader(this);
  TextStyle get detailHeaderStyle => AppTextStyles.detailHeader(this);
  TextStyle hintTextStyle({required Color color}) => AppTextStyles.hintText(this, color: color);
  TextStyle get buttonLightStyle => AppTextStyles.buttonLight(this);
  TextStyle get welcomeCardFinalStyle => AppTextStyles.welcomeCardFinal(this);
  TextStyle get crackItStyle => AppTextStyles.crackIt(this);

  // === SCREEN INFO ===
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  bool get isMobile => AppSizes.isMobile(this);
  bool get isTablet => AppSizes.isTablet(this);
  bool get isDesktop => AppSizes.isDesktop(this);

  // === CONVENIENCE WIDGETS ===
  Widget get verticalSpaceSmall => SizedBox(height: spaceBtwItemsH);
  Widget get verticalSpaceMedium => SizedBox(height: spaceBtwFields);
  Widget get verticalSpaceLarge => SizedBox(height: spaceBtwSections);
  Widget get horizontalSpaceSmall => SizedBox(width: spaceBtwItems);
  Widget get horizontalSpaceMedium => SizedBox(width: defaultSpace);
}