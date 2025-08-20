// widgets/info_row.dart
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final double labelWidth;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.labelWidth = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.paddingSM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: context.screenWidth * labelWidth,
            child: Text(
              label,
              style: context.hintTextGreyStyle,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: context.detailHeaderStyle,
            ),
          ),
        ],
      ),
    );
  }
}