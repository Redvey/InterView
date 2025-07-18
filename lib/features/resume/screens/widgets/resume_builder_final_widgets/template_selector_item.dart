import 'package:flutter/material.dart';
import 'package:interview/core/extensions/responsive_extension.dart';

class TemplateSelectorItem extends StatelessWidget {
  final String templatePath;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onPreview;

  const TemplateSelectorItem({
    super.key,
    required this.templatePath,
    required this.isSelected,
    required this.onTap,
    required this.onPreview,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.all(context.spaceLess / 2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(context.borderRadiusLg / 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(context.borderRadiusLg / 2),
                  child: Image.asset(templatePath),
                ),
              ),
              if (isSelected)
                const Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(Icons.check_circle, color: Colors.green),
                ),
            ],
          ),
          TextButton(
            onPressed: onPreview,
            child: const Text("Preview"),
          ),
        ],
      ),
    );
  }
}