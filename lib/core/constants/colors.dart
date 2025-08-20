import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Added for LinearGradient

class AppColors {
  AppColors._();

  // --- Background Colors ---
  static const Color backgroundYellow = Color(0xFFFFFDD0);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundRed = Color(0xFF993030);
  static const Color backgroundRedPink = Color(0xFFFF514F);
  static const Color backgroundBlue = Color(0xFF341899);
  static const Color backgroundSky = Color(0xff5729ff);
  static const Color backgroundGreen = Color(0xFF199B2A);
  static const Color darkGreen = Color(0xFF0F5D22);
  static const Color backgroundLime = Color(0xFF07E000);
  static const Color backgroundOrange = Color(0xFFD76400);
  static const Color darkOrange = Color(0xFFD73200);
  static const Color backgroundLightOrange = Color(0xFFF1995E);
  static const Color backgroundPink = Color(0xFFD7008F);
  static const Color backgroundLightPink = Color(0xFFF260EB);
  static const Color backgroundLightRed = Color(
    0xFFFFCBCB,
  ); // This was previously 'backgroundLightBlue', but the color value was for light pink. Renamed to avoid confusion with textBlueBg.
  static const Color backgroundGrey = Color(
    0xFFF5F5F5,
  ); // From second set of duplicates
  static const Color backgroundLightBlue2 = Color(
    0xFFE3F2FD,
  ); // From second set of duplicates, renamed to avoid conflict

  // --- Widget/Overlay Backgrounds ---
  static const Color purple = Color(0xFFB05CFF);
  static const Color darkPurple = Color(0xFF5500A5);
  static final Color purpleOverlay = purple.withAlpha(107);
  static const Color purpleLight = Color(0xFFE8D0FF);
  static final Color cardOverlay = backgroundWhite.withAlpha(26);

  // --- Gradient Backgrounds ---
  static const Gradient progressBar = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      darkPurple,
      purple,
    ],
  );

  static const Gradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundWhite, backgroundYellow],
  );
  static const Gradient onboard1 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [red, backgroundLightOrange],
  );
  static const Gradient onboard2 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundBlue, backgroundLightRed],
  );
  static const Gradient onboard3 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [darkGreen, backgroundGreen, textGreen],
  );
  static const Gradient onboard4 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [darkOrange, backgroundOrange, backgroundLightOrange, textYellow],
  );
  static const Gradient onboard5 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundRedPink, backgroundPink, backgroundLightPink],
  );
  static const Gradient interviewer = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xff211a2e), AppColors.blackLight, AppColors.black],
  );
  static const Gradient specialGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundLightPink, backgroundYellow],
  );
  static const Gradient interviewerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [blackLight, backgroundLightPink, blackLight],
  );
  static const Gradient resumeBuilderGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [backgroundRed, backgroundRedPink],
    stops: [0.0, 0.3],
  );
  static const Gradient reviewGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [backgroundBlue, backgroundSky],
  );
  static const Gradient flashcardGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [backgroundGreen, backgroundLime],
  );
  static const Gradient interviewGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [backgroundOrange, backgroundLightOrange],
  );
  static const Gradient coldMailGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [backgroundPink, backgroundLightPink],
  );
  static const Gradient starGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      backgroundOrange,
      backgroundLightOrange,
      backgroundYellow,
      backgroundWhite,
    ],
  );

  // --- Card Colors ---
  static const Color generalInformation = Color(0xFFC6B9FF);
  static const Color contactForm = Color(0xFF91E48A);
  static const Color educationForm = Color(0xFFFFB9B9);
  static const Color skillForm = Color(0xFFFFF1D6);
  static const Color rolesForm = Color(0xFFFFD6FA);
  static const Color projectForm = Color(0xFFFFB685);
  static const Color socialForm = Color(0xFFA6C8FF);
  static const Color jobForm = Color(0xFFFFBFE5);
  static const Color achievementsForm = Color(0xFF92FFEF);
  static const Color otherForm = Color(0xFFEDE3FF);
  static const Color chipBackground = Color(
    0xFFF5F5F5,
  ); // From second set of duplicates
  static const Color chipBorder = Color(
    0xFFE0E0E0,
  ); // From second set of duplicates

  // --- Search Field Colors ---
  static const Color searchFill = Color(0xFFE3F2FD);
  static const Color searchBorder = Color(0xFF90CAF9);
  static const Color searchFocused = Color(0xFF2196F3);
  static const Color searchHint = Color(0xFF42A5F5);

  // --- Text Colors ---
  static const Color black = Color(0xFF000000);
  static const Color blackLight = Color(
    0xFF1E1E1E,
  ); // Also an accent color in duplicates
  static const Color bottomBlack = Color(0xFF030306);
  static const Color bottomBlackLight = Color(0xFF101012);
  static const Color bottomGrey = Color(0xFF878789);
  static const Color textGrey = Color(
    0xFF757575,
  ); // Also textSecondary in duplicates
  static const Color textRed = Color(0xFFFF9594);
  static const Color textRedBg = Color(0xFFFFE7E7);
  static const Color textBlue = Color(0xFF94E3FF);
  static const Color textBlueBg = Color(0xFFE7EDFF);
  static const Color textGreen = Color(
    0xFF9BFF94,
  ); // Also a success color in duplicates
  static const Color textGreenBg = Color(
    0xFFE7FFF1,
  ); // Also successLight in duplicates
  static const Color textYellow = Color(0xFFFFFD94);
  static const Color textYellowBg = Color(0xFFFFFAE7);
  static const Color textPurple = Color(0xFFFF94F3);
  static const Color textPurpleBg = Color(0xFFFFE7F9);
  static const Color textPrimary = Color(
    0xFF212121,
  ); // From second set of duplicates
  static const Color textWhite = Color(
    0xFFFFFFFF,
  ); // From second set of duplicates
  static const Color textGrey2 = Color(
    0xFF9E9E9E,
  ); // From second set of duplicates, renamed to avoid conflict

  // --- Button Colors ---
  static const Color buttonPurple = Color(0xFFEFEAFF);
  static const Color buttonTextPurple = Color(0xFF6D3CFA);
  static const Color buttonBlue = Color(0xFFE5F3FE);
  static const Color buttonTextBlue = Color(0xFF008DFF);
  static const Color buttonGray = Color(0xFFF1F1F1);
  static const Color buttonTextGray = Color(0xFF787878);
  static const Color buttonRed = Color(0xFFFDEFEE);
  static const Color buttonTextRed = Color(0xFFEC6A5B);
  static const Color buttonYellow = Color(0xFFFEAA02);

  // --- Primary Colors ---
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color primaryLight = Color(0xFF42A5F5);

  // --- Accent Colors ---
  static const Color greyLight = Color(
    0xFFE0E0E0,
  ); // From second set of duplicates
  static const Color greyMedium = Color(
    0xFFBDBDBD,
  ); // From second set of duplicates
  static const Color greyDark = Color(
    0xFF616161,
  ); // From second set of duplicates
  static const Color bottomNavShadowAlpha = Color(0x001a0000);

  // Additional colors for the refactored components
  static const Color white = Color(0xFFFFFFFF); // Colors.white
  static const Color black87 = Color(
    0xDD000000,
  ); // Colors.black87 (87% opacity of black)
  static const Color red = Color(
    0xFFF44336,
  ); // Colors.red (default Material red)

  // Grey shades
  static const Color grey300 = Color(0xFFE0E0E0); // Colors.grey[300]
  static const Color grey400 = Color(0xFFBDBDBD); // Colors.grey[400]
  static const Color grey500 = Color(0xFF9E9E9E); // Colors.grey[500]

  // Blue shades
  static const Color blue50 = Color(0xFFE3F2FD); // Colors.blue[50]
  static const Color blue200 = Color(0xFF90CAF9); // Colors.blue[200]
  static const Color blue600 = Color(0xFF1976D2); // Colors.blue[600]
  static const Color blue700 = Color(0xFF1565C0);
  static const Color blue800 = Color(0x4D341899);

  static Color textGreenWithAlpha51 = textGreen.withAlpha(51);
  static Color textGreenWithAlpha26 = textGreen.withAlpha(26);

  // --- System/Feedback Colors ---
  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFFFCDD2);
  static const Color success = Color(0xFF388E3C);
  static const Color successLight = Color(0xFFC8E6C9);
  static const Color warning = Color(0xFFF57C00);
  static const Color warningLight = Color(0xFFFFE0B2);
  static const Color info = Color(0xFF1976D2);
  static const Color infoLight = Color(0xFFBBDEFB);

  static const Color personalInfoColor = AppColors.blue600;
  static const Color skillsColor = AppColors.backgroundGreen;
  static const Color preferencesColor = AppColors.backgroundOrange;
  static const Color termsBackgroundColor = AppColors.backgroundYellow;
  static const Color termsBorderColor = AppColors.buttonYellow;
}
