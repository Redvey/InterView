import 'package:flutter/material.dart';
import 'package:interview/features/resume_form/skill_form/sheet/skill_bottom_sheet_header.dart';
import 'package:interview/features/resume_form/skill_form/sheet/skill_list_view.dart';

import '../data/skill_categories.dart';
import '../model/skill_item.dart';


class SkillSelectionBottomSheet extends StatefulWidget {
  final List<String> initiallySelected;
  final Function(List<String>) onConfirm;
  final int maxSelection;

  const SkillSelectionBottomSheet({
    super.key,
    required this.initiallySelected,
    required this.onConfirm,
    this.maxSelection = 12,
  });

  @override
  State<SkillSelectionBottomSheet> createState() =>
      _SkillSelectionBottomSheetState();
}

class _SkillSelectionBottomSheetState
    extends State<SkillSelectionBottomSheet> {
  late final Map<String, List<SkillItem>> _skills;

  @override
  void initState() {
    super.initState();
    _skills = _deepClone(skillCategories);
    _preselectSkills();
  }

  void _preselectSkills() {
    for (var skill in _skills.values.expand((e) => e)) {
      if (widget.initiallySelected.contains(skill.name)) {
        skill.isSelected = true;
      }
    }
  }

  Map<String, List<SkillItem>> _deepClone(
      Map<String, List<SkillItem>> original) {
    return {
      for (var entry in original.entries)
        entry.key: entry.value
            .map((item) => SkillItem(
          name: item.name,
          icon: item.icon,
          isSelected: false,
        ))
            .toList(),
    };
  }

  List<SkillItem> get _selectedSkills =>
      _skills.values.expand((e) => e).where((s) => s.isSelected).toList();

  void _toggleSkill(SkillItem skill) {
    setState(() {
      skill.isSelected = !skill.isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = _selectedSkills.length;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          SkillBottomSheetHeader(
            selectedCount: selectedCount,
            maxSelection: widget.maxSelection,
            onConfirm: () {
              final selected = _selectedSkills.map((s) => s.name).toList();
              widget.onConfirm(selected);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SkillListView(
              skills: _skills,
              selectedCount: selectedCount,
              maxSelection: widget.maxSelection,
              onToggle: _toggleSkill,
            ),
          ),
        ],
      ),
    );
  }
}
