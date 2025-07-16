import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/sizes.dart';

Widget buildStarRating({
  double? rating,
  double? iconSize,
  int? maxStars,
  Gradient? gradient,
  double? spacing,
}) {
  final List<Widget> stars = [];

  final ratings = rating ?? 5;
  final iconSizes = iconSize ?? AppSizes.iconSize;
  final maxedStars = maxStars ?? AppSizes.maxStars;
  final gradient0 = gradient ?? AppColors.backgroundGradient;
  final spacing0 = spacing ?? AppSizes.starSpacing;

  for (int i = 0; i < maxedStars; i++) {
    if (i > 0) stars.add(SizedBox(width: spacing0));

    if (i + 1 <= ratings) {
      stars.add(_buildStar(iconSizes, gradient0, Icons.star_rounded));
    } else if (i + 0.5 <= ratings) {
      stars.add(_buildStar(iconSizes, gradient0, Icons.star_half_rounded));
    } else {
      stars.add(_buildStar(iconSizes, gradient0, Icons.star_border_rounded));
    }
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: stars,
  );
}


Widget _buildStar(double size, Gradient gradient, IconData icon) {
  return ShaderMask(
    shaderCallback: (bounds) => gradient.createShader(bounds),
    child: Icon(icon, size: size, color: AppColors.backgroundWhite),
  );
}
