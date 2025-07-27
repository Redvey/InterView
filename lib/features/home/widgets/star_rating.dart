import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

Widget buildStarRating(
    BuildContext context, {
      double? rating,
      double? iconSize,
      int? maxStars,
      Gradient? gradient,
      double? spacing,
    }) {
  final List<Widget> stars = [];

  final ratings = rating ?? 5;
  final iconSizes = iconSize ?? context.iconSize;
  final maxedStars = maxStars ?? 5;
  final gradient0 = gradient ?? AppColors.backgroundGradient;
  final spacing0 = spacing ?? context.starSpacing;

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

// Alternative: Widget class version for better organization
class StarRatingWidget extends StatelessWidget {
  final double? rating;
  final double? iconSize;
  final int? maxStars;
  final Gradient? gradient;
  final double? spacing;

  const StarRatingWidget({
    super.key,
    this.rating,
    this.iconSize,
    this.maxStars,
    this.gradient,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return buildStarRating(
      context,
      rating: rating,
      iconSize: iconSize,
      maxStars: maxStars,
      gradient: gradient,
      spacing: spacing,
    );
  }
}