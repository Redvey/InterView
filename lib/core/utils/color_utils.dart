import 'package:flutter/material.dart';

import '../constants/colors.dart';

Color getMatchingHintColor(Color backgroundColor) {
  final hsl = HSLColor.fromColor(backgroundColor);
  final darker = hsl.withLightness((hsl.lightness - 0.5).clamp(0.0, 1.0));
  return darker.toColor();
}

final darkerEducationColor = HSLColor.fromColor(AppColors.educationForm)
    .withLightness((HSLColor.fromColor(AppColors.educationForm).lightness - 0.1).clamp(0.0, 1.0))
    .toColor();

final lighterJobColor = HSLColor.fromColor(AppColors.jobForm)
    .withLightness((HSLColor.fromColor(AppColors.jobForm).lightness + 0.05).clamp(0.0, 1.0))
    .toColor();

final darkerJobColor = HSLColor.fromColor(AppColors.jobForm)
    .withLightness((HSLColor.fromColor(AppColors.jobForm).lightness - 0.5).clamp(0.0, 1.0))
    .toColor();

