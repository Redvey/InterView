
import 'package:flutter/cupertino.dart';

class AppColors{

  //background
  static const backgroundYellow = Color(0xFFFFFDD0);
  static const backgroundWhite = Color(0xFFFFFFFF);
  static const backgroundRed = Color(0xFF993030);
  static const backgroundRedPink = Color(0xFFFF514F);
  static const backgroundBlue = Color(0xFF341899);
  static const backgroundSky = Color(0xff5729ff);
  static const backgroundGreen = Color(0xFF199B2A);
  static const backgroundLime = Color(0xFF07E000);
  static const backgroundOrange = Color(0xFFD76400);
  static const backgroundLightOrange = Color(0xFFF1995E);
  static const backgroundPink = Color(0xFFD7008F);
  static const backgroundLightPink = Color(0xFFF260EB);

  //widget background
  static const purple = Color(0xFFB05CFF);
  static const purpleLight = Color(0xFFE8D0FF);

  // Gradient background
  static const backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      backgroundWhite,
      backgroundYellow,
    ],
    // stops: [0.0, 0.3],
  );
  static const resumeBuilderGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      backgroundRed,
      backgroundRedPink,
    ],
    stops: [0.0, 0.3],
  );
  static const reviewGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      backgroundBlue,
      backgroundSky,
    ],
    // stops: [0.0, 0.3],
  );
  static const flashcardGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      backgroundGreen,
      backgroundLime,
    ],
    // stops: [0.0, 0.3],
  );
  static const interviewGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      backgroundOrange,
      backgroundLightOrange,
    ],
    // stops: [0.0, 0.3],
  );
  static const coldMailGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      backgroundPink,
      backgroundLightPink,
    ],
    // stops: [0.0, 0.3],
  );

  //card colors
  static const generalInformation = Color(0xFFC6B9FF);
  static const contactForm = Color(0xFF91E48A);
  static const educationForm = Color(0xFFFFB9B9);
  static const skillForm = Color(0xFFFFF1D6);
  static const rolesForm = Color(0xFFFFD6FA);
  static const projectForm = Color(0xFFFFB685);
  static const socialForm = Color(0xFFA6C8FF);
  static const jobForm = Color(0xFFFFBFE5);
  static const achievementsForm = Color(0xFF92FFEF);
  static const otherForm = Color(0xFFEDE3FF);



  // Text Colors

  static const black = Color(0xFF000000);
  static const blackLight = Color(0xFF1E1E1E);

  static const textRed = Color(0xFFFF9594);
  static const textRedBg = Color(0xFFFFE7E7);

  static const textBlue = Color(0xFF94E3FF);
  static const textBlueBg = Color(0xFFE7EDFF);

  static const textGreen = Color(0xFF9BFF94);
  static const textGreenBg = Color(0xFFE7FFF1);

  static const textYellow = Color(0xFFFFFD94);
  static const textYellowBg = Color(0xFFFFFAE7);

  static const textPurple = Color(0xFFFF94F3);
  static const textPurpleBg = Color(0xFFFFE7F9);

  //button colors
  static const buttonPurple = Color(0xFFEFEAFF); // Button background: EFEAFF, Text: 6D3CFA
  static const buttonTextPurple = Color(0xFF6D3CFA);

  static const buttonBlue = Color(0xFFE5F3FE); // Button background: E5F3FE, Text: 008DFF
  static const buttonTextBlue = Color(0xFF008DFF);

  static const buttonGray = Color(0xFFF1F1F1); // Button background: E1FAE8, Text: 37C25C
  static const buttonTextGray = Color(0xFF787878);

  static const buttonRed = Color(0xFFFDEFEE); // Button background: FDEFEE, Text: EC6A5B
  static const buttonTextRed = Color(0xFFEC6A5B);


}