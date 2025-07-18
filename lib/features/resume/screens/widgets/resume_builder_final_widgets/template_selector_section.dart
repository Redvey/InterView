import 'package:flutter/material.dart';
import 'package:interview/features/resume/screens/widgets/resume_builder_final_widgets/template_selector_item.dart';
import 'package:interview/features/resume/widgets/template_preview.dart';


class TemplateSelectorSection extends StatelessWidget {
  final List<String> templates;
  final int selectedIndex;
  final ValueChanged<int> onTemplateSelected;

  const TemplateSelectorSection({
    super.key,
    required this.templates,
    required this.selectedIndex,
    required this.onTemplateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(templates.length, (index) {
        return Expanded(
          child: TemplateSelectorItem(
            templatePath: templates[index],
            isSelected: index == selectedIndex,
            onTap: () => onTemplateSelected(index),
            onPreview: () => _showPreview(context, templates[index]),
          ),
        );
      }),
    );
  }

  void _showPreview(BuildContext context, String templatePath) {
    showDialog(
      context: context,
      builder: (_) => TemplatePreviewDialog(
        templatePath: templatePath,
      ),
    );
  }
}