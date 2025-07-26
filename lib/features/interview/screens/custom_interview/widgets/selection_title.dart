import 'package:flutter/material.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import '../../../../../app/themes/text_styles.dart';
class SectionTitleWidget extends StatelessWidget {
  final String title;

  const SectionTitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: context.sm),
      child: Text(
        title,
        style: AppTextStyles.sectionTitle(context),
      ),
    );
  }
}