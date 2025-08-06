import 'package:flutter/material.dart';
import '../../../app/themes/text_styles.dart';
import '../../constants/sizes.dart';

extension ResponsiveContext on BuildContext {

  // ═══════════════════════════════════════════════════════════════════════════
  // 🎯 BASIC SIZES
  // ═══════════════════════════════════════════════════════════════════════════

  // Extra Small to Extra Large Sizes
  double get xs => AppSizes.xs(this);
  double get sm => AppSizes.sm(this);
  double get md => AppSizes.md(this);
  double get lg => AppSizes.lg(this);
  double get xl => AppSizes.xl(this);
  double get xxl => AppSizes.xxl(this);
  double get xxxl => AppSizes.xxxl(this);

  // Margin Sizes
  double get mx => AppSizes.mx(this);
  double get mxs => AppSizes.mxs(this);
  double get mxW => AppSizes.mxW(this);
  double get mdV => AppSizes.mdV(this);
  double get lgV => AppSizes.lgV(this);
  double get lgA => AppSizes.lgAnim(this);
  double get xlV => AppSizes.xlV(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 📐 PADDING SIZES
  // ═══════════════════════════════════════════════════════════════════════════

  double get paddingXS => AppSizes.paddingXS(this);
  double get paddingSM => AppSizes.paddingSM(this);
  double get paddingMD => AppSizes.paddingMD(this);
  double get paddingLG => AppSizes.paddingLG(this);
  double get paddingXL => AppSizes.paddingXL(this);
  double get paddingXXL => AppSizes.paddingXXL(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 🔘 BORDER RADIUS SIZES
  // ═══════════════════════════════════════════════════════════════════════════

  // New Radius System
  double get radiusXS => AppSizes.radiusXS(this);
  double get radiusSM => AppSizes.radiusSM(this);
  double get radiusMD => AppSizes.radiusMD(this);
  double get radiusLG => AppSizes.radiusLG(this);
  double get radiusXL => AppSizes.radiusXL(this);

  // Legacy Radius System
  double get borderRadiusSm => AppSizes.borderRadiusSm(this);
  double get borderRadiusMd => AppSizes.borderRadiusMd(this);
  double get borderRadiusLg => AppSizes.borderRadiusLg(this);
  double get borderRadiusLx => AppSizes.borderRadiusLx(this);
  double get sheetRadius => AppSizes.sheetRadius(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 📏 BORDER WIDTHS
  // ═══════════════════════════════════════════════════════════════════════════

  double get borderWidthThin => AppSizes.borderWidthThin(this);
  double get borderWidthDefault => AppSizes.borderWidthDefault(this);
  double get borderWidthThick => AppSizes.borderWidthThick(this);
  double get bottomWidth => AppSizes.bottomWidth(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 🎨 ICON SIZES
  // ═══════════════════════════════════════════════════════════════════════════

  double get iconSize => AppSizes.iconSize(this);
  double get iconSizeSm => AppSizes.iconSizeSm(this);
  double get iconSizeSM => AppSizes.iconSizeSM(this);
  double get iconSizeSX => AppSizes.iconSizeSX(this);
  double get iconSizeMD => AppSizes.iconSizeMD(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 📝 FONT SIZES
  // ═══════════════════════════════════════════════════════════════════════════

  double get fontSizeSs => AppSizes.fontSizeSs(this);
  double get fontSizeSms => AppSizes.fontSizeSms(this);
  double get fontSizeSm => AppSizes.fontSizeSm(this);
  double get fontSizeSx => AppSizes.fontSizeSx(this);
  double get fontSizeSd => AppSizes.fontSizeSd(this);
  double get fontSizeMd => AppSizes.fontSizeMd(this);
  double get fontSizeLg => AppSizes.fontSizeLg(this);
  double get letterSpacing => AppSizes.letterSpacing(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 🔲 BUTTON DIMENSIONS
  // ═══════════════════════════════════════════════════════════════════════════

  double get buttonHeight => AppSizes.buttonHeight(this);
  double get buttonRadius => AppSizes.buttonRadius(this);
  double get circularButtonRadius => AppSizes.circularButtonRadius(this);
  double get buttonWidth => AppSizes.buttonWidth(this);
  double get buttonElevation => AppSizes.buttonElevation(this);
  double get createButtonHeight => AppSizes.createButtonHeight(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 🖼️ IMAGE & MEDIA SIZES
  // ═══════════════════════════════════════════════════════════════════════════

  double get imageThumbSize => AppSizes.imageThumbSize(this);
  double get profileHeight => AppSizes.profileHeight(this);
  double get profileWidth => AppSizes.profileWidth(this);
  double get lottieHeight => AppSizes.lottieHeight(this);
  double get lottieWidth => AppSizes.lottieWidth(this);
  double get productImageSize => AppSizes.productImageSize(this);
  double get productImageRadius => AppSizes.productImageRadius(this);
  double get productItemHeight => AppSizes.productItemHeight(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 🌟 SHADOW & BLUR EFFECTS
  // ═══════════════════════════════════════════════════════════════════════════

  double get welcomeBlur => AppSizes.welcomeBlur(this);
  double get welcomeSpread => AppSizes.welcomeSpread(this);
  double get glowBlur => AppSizes.glowBlur(this);
  double get glowSpread => AppSizes.glowSpread(this);
  double get metaBlur => AppSizes.metaBlur(this);

  // Shadow Offsets
  double get shadowOffsetY => AppSizes.shadowOffsetY(this);
  double get shadowOffsetY2 => AppSizes.shadowOffsetY2(this);
  double get shadowOffsetX2 => AppSizes.shadowOffsetX2(this);
  double get zero => AppSizes.zero(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // ✨ GLOW BAR SIZES
  // ═══════════════════════════════════════════════════════════════════════════

  double get glowH => AppSizes.glowH(this);
  double get glowBorderRadius => AppSizes.glowBorderRadius(this);
  double get glowW => AppSizes.glowW(this);
  double get glowB => AppSizes.glowB(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 📊 SPACING - HORIZONTAL
  // ═══════════════════════════════════════════════════════════════════════════

  double get spaceLess => AppSizes.spaceLess(this);
  double get defaultSpace => AppSizes.defaultSpace(this);
  double get spaceBtwItems => AppSizes.spaceBtwItems(this);
  double get headSubhead => AppSizes.headSubhead(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 📏 SPACING - VERTICAL
  // ═══════════════════════════════════════════════════════════════════════════

  double get spaceLessH => AppSizes.spaceLessH(this);
  double get fieldLabelSpacing => AppSizes.fieldLabelSpacing(this);
  double get defaultSpaceH => AppSizes.defaultSpaceH(this);
  double get spaceBtwItemsH => AppSizes.spaceBtwItemsH(this);
  double get spaceBtwFields => AppSizes.spaceBtwFields(this);
  double get spaceBtwSections => AppSizes.spaceBtwSections(this);
  double get extraSpacingForButton => AppSizes.extraSpacingForButton(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 🎯 SPECIAL DIMENSIONS
  // ═══════════════════════════════════════════════════════════════════════════

  double get handleWidth => AppSizes.handleWidth(this);
  double get handleHeight => AppSizes.handleHeight(this);
  double get dividerHeight => AppSizes.dividerHeight(this);
  double get inputFieldRadius => AppSizes.inputFieldRadius(this);
  double get spaceBtwInputFields => AppSizes.spaceBtwInputFields(this);
  double get recentSearches => AppSizes.recentSearches(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 🏠 CARD DIMENSIONS
  // ═══════════════════════════════════════════════════════════════════════════

  double get adCard => AppSizes.adCard(this);
  double get featureCard => AppSizes.featureCard(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // ⭐ RATING & STAR SIZES
  // ═══════════════════════════════════════════════════════════════════════════

  double get starSpacing => AppSizes.starSpacing(this);
  int get maxStars => AppSizes.maxStars;

  // ═══════════════════════════════════════════════════════════════════════════
  // 🔢 CONSTANTS & LIMITS
  // ═══════════════════════════════════════════════════════════════════════════

  int get textFieldMaxLines => AppSizes.textFieldMaxLines;
  int get maxSelection => AppSizes.maxSelection;

  // Sheet Sizes (ratios)
  double get sheetInitialSize => AppSizes.sheetInitialSize;
  double get sheetMinSize => AppSizes.sheetMinSize;
  double get sheetMaxSize => AppSizes.sheetMaxSize;

  // ═══════════════════════════════════════════════════════════════════════════
  // 🧭 BOTTOM NAVIGATION SIZES
  // ═══════════════════════════════════════════════════════════════════════════

  // Container Dimensions
  double get bottomNavHeight => AppSizes.bottomNavHeight(this);
  double get bottomNavBottomPadding => AppSizes.bottomNavBottomPadding(this);
  double get bottomNavRadius => AppSizes.bottomNavRadius(this);
  double get bottomNavHorizontalPadding => AppSizes.bottomNavHorizontalPadding(this);

  // Shadow Properties
  double get bottomNavShadowBlur => AppSizes.bottomNavShadowBlur(this);
  double get bottomNavShadowOffsetY => AppSizes.bottomNavShadowOffsetY(this);
  double get bottomNavShadowAlpha => AppSizes.bottomNavShadowAlpha(this);

  // Icon Container
  double get navIconPaddingHorizontal => AppSizes.navIconPaddingHorizontal(this);
  double get navIconPaddingVertical => AppSizes.navIconPaddingVertical(this);
  double get navIconBorderRadius => AppSizes.navIconBorderRadius(this);

  // Icon Sizes
  double get navIconSizeSelected => AppSizes.navIconSizeSelected(this);
  double get navIconSizeUnselected => AppSizes.navIconSizeUnselected(this);

  // Label Properties
  double get navLabelPaddingLeft => AppSizes.navLabelPaddingLeft(this);
  double get navLabelFontSize => AppSizes.navLabelFontSize(this);

  // Animation Duration
  int get navAnimationDuration => AppSizes.navAnimationDuration;

  // ═══════════════════════════════════════════════════════════════════════════
  // 🌊 LIQUID MENU OVERLAY SIZES
  // ═══════════════════════════════════════════════════════════════════════════

  // Profile Button Animations
  double get profileTranslateX => AppSizes.profileTranslateX(this);

  // Close Button Properties
  double get closeButtonHideOffset => AppSizes.closeButtonHideOffset(this);
  int get closeButtonOpacity => AppSizes.closeButtonOpacity;
  double get closeButtonIconSize => AppSizes.closeButtonIconSize(this);

  // User Greeting Animation Properties
  int get userGreetingAnimationDuration => AppSizes.userGreetingAnimationDuration;
  double get userGreetingTranslateX => AppSizes.userGreetingTranslateX(this);
  double get userGreetingPadding => AppSizes.userGreetingPadding(this);
  double get userAvatarRadius => AppSizes.userAvatarRadius(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 📦 EDGE INSETS
  // ═══════════════════════════════════════════════════════════════════════════

  EdgeInsets get screenPadding => AppSizes.screenPadding(this);
  EdgeInsets get defaultPadding => AppSizes.defaultPadding(this);
  EdgeInsets get horizontalPadding => AppSizes.horizontalPadding(this);
  EdgeInsets get verticalPadding => AppSizes.verticalPadding(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 🎨 TEXT STYLES - BASIC
  // ═══════════════════════════════════════════════════════════════════════════

  TextStyle get textFieldStyle => AppTextStyles.textField(this);
  TextStyle get bodyBoldStyle => AppTextStyles.bodyBold(this);
  TextStyle headingStyle({required Color color}) => AppTextStyles.heading(this, color: color);
  TextStyle subheadingStyle({required Color color}) => AppTextStyles.subheading(this, color: color);
  TextStyle get welcomeStyle => AppTextStyles.welcome(this);
  TextStyle get featureTitleStyle => AppTextStyles.featureTitle(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 📄 TEXT STYLES - HEADERS & INFO
  // ═══════════════════════════════════════════════════════════════════════════

  TextStyle get infoHeaderStyle => AppTextStyles.infoHeader(this);
  TextStyle get infoSmallHeaderStyle => AppTextStyles.infoSmallHeader(this);
  TextStyle get detailHeaderStyle => AppTextStyles.detailHeader(this);
  TextStyle get headerStyle => AppTextStyles.header(this);
  TextStyle get sectionTitleStyle => AppTextStyles.sectionTitle(this);
  TextStyle get interviewInformationTitleStyle => AppTextStyles.interviewInformationTitle(this);
  TextStyle get interviewInformationSubTitleStyle => AppTextStyles.interviewInformationSubTitle(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 💬 TEXT STYLES - HINTS & HELPER TEXT
  // ═══════════════════════════════════════════════════════════════════════════

  TextStyle hintTextStyle({required Color color}) => AppTextStyles.hintText(this, color: color);
  TextStyle get hintTextGreyStyle => AppTextStyles.hintTextGrey(this);
  TextStyle get searchHintStyle => AppTextStyles.searchHint(this);
  TextStyle get emptyStateHintStyle => AppTextStyles.emptyStateHint(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 🔘 TEXT STYLES - BUTTONS
  // ═══════════════════════════════════════════════════════════════════════════

  TextStyle get buttonLightStyle => AppTextStyles.buttonLight(this);
  TextStyle get buttonSmallStyle => AppTextStyles.buttonSmall(this);
  TextStyle get buttonTextStyle => AppTextStyles.buttonText(this);
  TextStyle get buttonWhiteTextStyle => AppTextStyles.buttonWhiteText(this);
  TextStyle get yesStyle => AppTextStyles.yes(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 🏷️ TEXT STYLES - CHIPS & TAGS
  // ═══════════════════════════════════════════════════════════════════════════

  TextStyle get chipTextStyle => AppTextStyles.chipText(this);
  TextStyle get chipSelectedStyle => AppTextStyles.chipSelected(this);
  TextStyle get chipUnselectedStyle => AppTextStyles.chipUnselected(this);
  TextStyle get filterChipSelectedStyle => AppTextStyles.filterChipSelected(this);
  TextStyle get filterChipUnselectedStyle => AppTextStyles.filterChipUnselected(this);
  TextStyle get customChipTextStyle => AppTextStyles.customChipText(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 🎯 TEXT STYLES - SPECIAL CONTENT
  // ═══════════════════════════════════════════════════════════════════════════

  TextStyle get welcomeCardFinalStyle => AppTextStyles.welcomeCardFinal(this);
  TextStyle get subscriptionTitleStyle => AppTextStyles.subscriptionTitle(this);
  TextStyle get crackItStyle => AppTextStyles.crackIt(this);
  TextStyle get membershipSubTitleStyle => AppTextStyles.membershipSubTitle(this);
  TextStyle get membershipDetailStyle => AppTextStyles.membershipDetail(this);
  TextStyle get infoTextStyle => AppTextStyles.infoText(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 💼 TEXT STYLES - INTERVIEW & JOB CONTENT
  // ═══════════════════════════════════════════════════════════════════════════

  TextStyle get interviewTemplateJobStyle => AppTextStyles.interviewTemplateJob(this);
  TextStyle get interviewTemplateJobDescriptionStyle => AppTextStyles.interviewTemplateJobDescription(this);
  TextStyle get noInterviewsFoundStyle => AppTextStyles.noInterviewsFound(this);
  TextStyle labelStyleCategory(bool isSelected) => AppTextStyles.labelStyleCategory(this, isSelected);

  // ═══════════════════════════════════════════════════════════════════════════
  // 📋 TEXT STYLES - REPORTS & ANALYTICS
  // ═══════════════════════════════════════════════════════════════════════════

  TextStyle get interviewReportsTitleStyle => AppTextStyles.interviewReportsTitle(this);
  TextStyle get dateHeaderStyle => AppTextStyles.dateHeader(this);
  TextStyle get roleTitleStyle => AppTextStyles.roleTitle(this);
  TextStyle get topicSummaryStyle => AppTextStyles.topicSummary(this);
  TextStyle get timestampStyle => AppTextStyles.timestamp(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 💬 TEXT STYLES - DIALOG & MODAL
  // ═══════════════════════════════════════════════════════════════════════════

  TextStyle get dialogBoxTitleStyle => AppTextStyles.dialogBoxTitle(this);
  TextStyle get dialogBoxSubTitleStyle => AppTextStyles.dialogBoxSubTitle(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 🧭 TEXT STYLES - NAVIGATION
  // ═══════════════════════════════════════════════════════════════════════════

  TextStyle navTextStyle(Color selectedColor) => AppTextStyles.navTextStyle(this, selectedColor);

  // ═══════════════════════════════════════════════════════════════════════════
  // 📱 SCREEN INFORMATION
  // ═══════════════════════════════════════════════════════════════════════════

  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  bool get isMobile => AppSizes.isMobile(this);
  bool get isTablet => AppSizes.isTablet(this);
  bool get isDesktop => AppSizes.isDesktop(this);

  // ═══════════════════════════════════════════════════════════════════════════
  // 🎛️ CONVENIENCE WIDGETS
  // ═══════════════════════════════════════════════════════════════════════════

  // Vertical Spacing Widgets
  Widget get verticalSpaceSmall => SizedBox(height: spaceBtwItemsH);
  Widget get verticalSpaceMedium => SizedBox(height: spaceBtwFields);
  Widget get verticalSpaceLarge => SizedBox(height: spaceBtwSections);

  // Horizontal Spacing Widgets
  Widget get horizontalSpaceSmall => SizedBox(width: spaceBtwItems);
  Widget get horizontalSpaceMedium => SizedBox(width: defaultSpace);
}