import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/features/resume/screens/widgets/selectable_item_bottom_sheet.dart';
import 'package:interview/features/resume/screens/widgets/selectable_item_wrap.dart';
import 'package:interview/features/resume/screens/skill_form/data/skill_data.dart';

import '../widgets/selectable_controller.dart';

class SkillForm extends StatefulWidget {
  const SkillForm({super.key});

  @override
  State<SkillForm> createState() => _SkillFormState();
}

class _SkillFormState extends State<SkillForm> {
  final GenericSelectableController _controller = GenericSelectableController();

  void _showSkillBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SelectableItemBottomSheet(
        title: "Select Skills",
        sheetColor: AppColors.skillForm,
        categoryData: skillData,
        initiallySelected: _controller.selectedItems,
        maxSelection: 12,
        onConfirm: (selected) {
          setState(() {
            _controller.setItems(selected);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.skillForm,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your Skills", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SelectableItemWrap(
              selectedItems: _controller.selectedItems,
              onDelete: (item) => _controller.removeItem(item, () => setState(() {})),
              onAdd: _showSkillBottomSheet,
              addLabel: " Add Skill",
            ),

          ],
        ),
      ),
    );
  }
}
