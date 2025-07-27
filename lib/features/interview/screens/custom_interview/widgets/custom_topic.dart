import 'package:flutter/material.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../core/constants/colors.dart';
import '../../../helper/input_decoration_interview_helper.dart';

class CustomTopicInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAddTopic;

  const CustomTopicInputWidget({
    super.key,
    required this.controller,
    required this.onAddTopic,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecorationHelper.buildInputDecoration(
              AppStrings.addCustomTopicHint,context),
            onFieldSubmitted: (_) => onAddTopic(),
          ),
        ),
        SizedBox(width: context.sm),
        IconButton(
          onPressed: onAddTopic,
          icon: const Icon(Icons.add_circle),
          color: AppColors.backgroundGreen,
        ),
      ],
    );
  }
}
