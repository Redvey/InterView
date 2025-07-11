import 'package:flutter/material.dart';
import '../../../core/constants/sizes.dart';
import '../../../app/themes/text_styles.dart';
import '../../../core/utils/color_utils.dart';
import 'input_decoration.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType keyboardType;
  final Color containerColor;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool removable;
  final VoidCallback? onRemove;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.containerColor,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.removable = false,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final Color hintTextColor = getMatchingHintColor(containerColor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label and (optional) Remove button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label.toUpperCase(), style: AppTextStyles.detailHeader),
            if (removable && onRemove != null)
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red, size: 20),
                onPressed: onRemove,
              ),
          ],
        ),
        const SizedBox(height: 8),

        // Text Field
        TextField(
          controller: controller,
          focusNode: focusNode,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textInputAction:
          nextFocus != null ? TextInputAction.next : TextInputAction.done,
          onEditingComplete: () {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            } else {
              focusNode?.unfocus();
            }
          },
          decoration: whiteInputDecoration(hint, hintTextColor),
        ),

        const SizedBox(height: AppSizes.spaceBtwFields),
      ],
    );
  }
}
