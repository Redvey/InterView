import 'package:flutter/material.dart';
import '../../../app/themes/text_styles.dart';
import '../../constants/sizes.dart';



extension ResponsiveContext on BuildContext {

  // === SIZES ===

  // NEWLY ADDED RESPONSIVE SIZES
  double get xs => AppSizes.xs(this);
  double get sm => AppSizes.sm(this);
  double get xxl => AppSizes.xxl(this);
  double get xxxl => AppSizes.xxxl(this);

  // NEWLY ADDED RESPONSIVE PADDING
  double get paddingXS => AppSizes.paddingXS(this);
  double get paddingSM => AppSizes.paddingSM(this);
  double get paddingMD => AppSizes.paddingMD(this);
  double get paddingLG => AppSizes.paddingLG(this);
  double get paddingXL => AppSizes.paddingXL(this);
  double get paddingXXL => AppSizes.paddingXXL(this);

  // NEWLY ADDED RESPONSIVE BORDER RADIUS
  double get radiusXS => AppSizes.radiusXS(this);
  double get radiusSM => AppSizes.radiusSM(this);
  double get radiusMD => AppSizes.radiusMD(this);
  double get radiusLG => AppSizes.radiusLG(this);
  double get radiusXL => AppSizes.radiusXL(this);

  // NEWLY ADDED RESPONSIVE HEIGHTS & WIDTHS
  double get createButtonHeight => AppSizes.createButtonHeight(this);
  double get handleWidth => AppSizes.handleWidth(this);
  double get handleHeight => AppSizes.handleHeight(this);
  int get textFieldMaxLines => AppSizes.textFieldMaxLines;
  double get iconSizeSM => AppSizes.iconSizeSM(this);
  double get iconSizeSX => AppSizes.iconSizeSX(this);
  double get iconSizeMD => AppSizes.iconSizeMD(this);

  // Sheet Sizes (remain static as they are ratios)
  double get sheetInitialSize => AppSizes.sheetInitialSize;
  double get sheetMinSize => AppSizes.sheetMinSize;
  double get sheetMaxSize => AppSizes.sheetMaxSize;

  // NEWLY ADDED RESPONSIVE FONT SIZES
  double get fontSizeSM => AppSizes.fontSizeSM(this); // Note: Conflicts with existing `fontSizeSm`, keep both as per request.
  double get fontSizeMD => AppSizes.fontSizeMD(this); // Note: Conflicts with existing `fontSizeMd`, keep both as per request.
  double get fontSizeLG => AppSizes.fontSizeLG(this); // Note: Conflicts with existing `fontSizeLg`, keep both as per request.

  // NEWLY ADDED EXTRA SPACING
  double get extraSpacingForButton => AppSizes.extraSpacingForButton(this);


  // Padding and margins (Existing, untouched)
  double get md => AppSizes.md(this);
  double get mx => AppSizes.mx(this);
  double get mxs => AppSizes.mxs(this);
  double get mxW => AppSizes.mxW(this);
  double get mdV => AppSizes.mdV(this);
  double get lg => AppSizes.lg(this);
  double get lgV => AppSizes.lgV(this);
  double get lgA => AppSizes.lgAnim(this);
  double get xl => AppSizes.xl(this);
  double get xlV => AppSizes.xlV(this);

  // Icons (Existing, untouched)
  double get iconSize => AppSizes.iconSize(this);
  double get iconSizeSm => AppSizes.iconSizeSm(this);


  // Blur & spread (Existing, untouched)
  double get welcomeBlur => AppSizes.welcomeBlur(this);
  double get welcomeSpread => AppSizes.welcomeSpread(this);
  double get glowBlur => AppSizes.glowBlur(this);
  double get glowSpread => AppSizes.glowSpread(this);
  double get metaBlur => AppSizes.metaBlur(this);

  // Glow bars (Existing, untouched)
  double get glowH => AppSizes.glowH(this);
  double get glowW => AppSizes.glowW(this);
  double get glowB => AppSizes.glowB(this);

  // Border widths (Existing, untouched)
  double get borderWidthThin => AppSizes.borderWidthThin(this);
  double get borderWidthDefault => AppSizes.borderWidthDefault(this);
  double get borderWidthThick => AppSizes.borderWidthThick(this);

  // Font sizes (Existing, untouched)
  double get fontSizeSs => AppSizes.fontSizeSs(this);
  // `fontSizeSm` conflict handled above.
  double get fontSizeSx => AppSizes.fontSizeSx(this);
  double get fontSizeSd => AppSizes.fontSizeSd(this);
  // `fontSizeMd` conflict handled above.
  // `fontSizeLg` conflict handled above.

  // Buttons (Existing, untouched)
  double get buttonHeight => AppSizes.buttonHeight(this);
  double get buttonRadius => AppSizes.buttonRadius(this);
  double get circularButtonRadius => AppSizes.circularButtonRadius(this);
  double get buttonWidth => AppSizes.buttonWidth(this);
  double get buttonElevation => AppSizes.buttonElevation(this);

  // Images (Existing, untouched)
  double get imageThumbSize => AppSizes.imageThumbSize(this);
  double get profileHeight => AppSizes.profileHeight(this);
  double get profileWidth => AppSizes.profileWidth(this);

  //success-screen (Existing, untouched)
  double get lottieHeight => AppSizes.lottieHeight(this);
  double get lottieWidth => AppSizes.lottieWidth(this);

  // Offsets (Existing, untouched)
  double get shadowOffsetY => AppSizes.shadowOffsetY(this);
  double get shadowOffsetY2 => AppSizes.shadowOffsetY2(this);
  double get shadowOffsetX2 => AppSizes.shadowOffsetX2(this);
  double get zero => AppSizes.zero(this);

  // Horizontal spacing (Existing, untouched)
  double get spaceLess => AppSizes.spaceLess(this);
  double get defaultSpace => AppSizes.defaultSpace(this);
  double get spaceBtwItems => AppSizes.spaceBtwItems(this);
  double get headSubhead => AppSizes.headSubhead(this);

  // Vertical spacing (Existing, untouched)
  double get spaceLessH => AppSizes.spaceLessH(this);
  double get fieldLabelSpacing => AppSizes.fieldLabelSpacing(this);
  double get defaultSpaceH => AppSizes.defaultSpaceH(this);
  double get spaceBtwItemsH => AppSizes.spaceBtwItemsH(this);
  double get spaceBtwFields => AppSizes.spaceBtwFields(this);
  double get spaceBtwSections => AppSizes.spaceBtwSections(this);

  // Border radius (Existing, untouched)
  double get borderRadiusSm => AppSizes.borderRadiusSm(this);
  double get borderRadiusMd => AppSizes.borderRadiusMd(this);
  double get borderRadiusLg => AppSizes.borderRadiusLg(this);
  double get borderRadiusLx => AppSizes.borderRadiusLx(this);
  double get sheetRadius => AppSizes.sheetRadius(this);

  // Divider (Existing, untouched)
  double get dividerHeight => AppSizes.dividerHeight(this);

  // Product items (Existing, untouched)
  double get productImageSize => AppSizes.productImageSize(this);
  double get productImageRadius => AppSizes.productImageRadius(this);
  double get productItemHeight => AppSizes.productItemHeight(this);

  // Input fields (Existing, untouched)
  double get inputFieldRadius => AppSizes.inputFieldRadius(this);
  double get spaceBtwInputFields => AppSizes.spaceBtwInputFields(this);

  // Welcome cards (Existing, untouched)
  double get adCard => AppSizes.adCard(this);
  double get featureCard => AppSizes.featureCard(this);

  // Star rating (Existing, untouched)
  double get starSpacing => AppSizes.starSpacing(this);
  int get maxStars => AppSizes.maxStars;

  // === BOTTOM NAVIGATION SPECIFIC EXTENSIONS ===

  // Bottom nav container (Existing, untouched)
  double get bottomNavHeight => AppSizes.bottomNavHeight(this);
  double get bottomNavBottomPadding => AppSizes.bottomNavBottomPadding(this);
  double get bottomNavRadius => AppSizes.bottomNavRadius(this);
  double get bottomNavHorizontalPadding => AppSizes.bottomNavHorizontalPadding(this);

  // Bottom nav shadow (Existing, untouched)
  double get bottomNavShadowBlur => AppSizes.bottomNavShadowBlur(this);
  double get bottomNavShadowOffsetY => AppSizes.bottomNavShadowOffsetY(this);
  double get bottomNavShadowAlpha => AppSizes.bottomNavShadowAlpha(this);

  // Nav icon container (Existing, untouched)
  double get navIconPaddingHorizontal => AppSizes.navIconPaddingHorizontal(this);
  double get navIconPaddingVertical => AppSizes.navIconPaddingVertical(this);
  double get navIconBorderRadius => AppSizes.navIconBorderRadius(this);

  // Nav icon sizes (Existing, untouched)
  double get navIconSizeSelected => AppSizes.navIconSizeSelected(this);
  double get navIconSizeUnselected => AppSizes.navIconSizeUnselected(this);

  // Nav label (Existing, untouched)
  double get navLabelPaddingLeft => AppSizes.navLabelPaddingLeft(this);
  double get navLabelFontSize => AppSizes.navLabelFontSize(this);

  // Animation durations (Existing, untouched)
  int get navAnimationDuration => AppSizes.navAnimationDuration;

  // === NEW ADDITIONS FOR LIQUID MENU OVERLAY ===

  // Profile button animations (Existing, untouched)
  double get profileTranslateX => AppSizes.profileTranslateX(this);

  // Close button properties (Existing, untouched)
  double get closeButtonHideOffset => AppSizes.closeButtonHideOffset(this);
  int get closeButtonOpacity => AppSizes.closeButtonOpacity;
  double get closeButtonIconSize => AppSizes.closeButtonIconSize(this);

  // User greeting animation properties (Existing, untouched)
  int get userGreetingAnimationDuration => AppSizes.userGreetingAnimationDuration;
  double get userGreetingTranslateX => AppSizes.userGreetingTranslateX(this);
  double get userGreetingPadding => AppSizes.userGreetingPadding(this);
  double get userAvatarRadius => AppSizes.userAvatarRadius(this);

  // === EDGE INSETS === (Existing, untouched)
  EdgeInsets get screenPadding => AppSizes.screenPadding(this);
  EdgeInsets get defaultPadding => AppSizes.defaultPadding(this);
  EdgeInsets get horizontalPadding => AppSizes.horizontalPadding(this);
  EdgeInsets get verticalPadding => AppSizes.verticalPadding(this);

  // === TEXT STYLES === (Existing, untouched)
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
  TextStyle get  crackItStyle => AppTextStyles.crackIt(this);
  TextStyle get membershipSubTitle => AppTextStyles.membershipSubTitle(this);


  // === SCREEN INFO === (Existing, untouched)
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  bool get isMobile => AppSizes.isMobile(this);
  bool get isTablet => AppSizes.isTablet(this);
  bool get isDesktop => AppSizes.isDesktop(this);

  // === CONVENIENCE WIDGETS === (Existing, untouched)
  Widget get verticalSpaceSmall => SizedBox(height: spaceBtwItemsH);
  Widget get verticalSpaceMedium => SizedBox(height: spaceBtwFields);
  Widget get verticalSpaceLarge => SizedBox(height: spaceBtwSections);
  Widget get horizontalSpaceSmall => SizedBox(width: spaceBtwItems);
  Widget get horizontalSpaceMedium => SizedBox(width: defaultSpace);


  //constants
  int get maxSelection => AppSizes.maxSelection;
}