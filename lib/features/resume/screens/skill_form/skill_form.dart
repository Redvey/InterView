import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/features/resume/screens/widgets/selectable_item_bottom_sheet.dart';
import 'package:interview/features/resume/screens/widgets/selectable_item_wrap.dart';
import 'package:interview/features/resume/screens/skill_form/data/skill_data.dart';
import '../../../../core/utils/extensions/responsive_extension.dart';
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(context.radiusLG)),
      ),
      builder: (context) => SelectableItemBottomSheet(
        title: AppStrings.selectSkills,
        sheetColor: AppColors.skillForm,
        categoryData: skillData,
        initiallySelected: _controller.selectedItems,
        maxSelection: context.maxSelection,
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
      padding: EdgeInsets.all(context.paddingMD),
      child: Container(
        padding: EdgeInsets.all(context.paddingMD),
        decoration: BoxDecoration(
          color: AppColors.skillForm,
          borderRadius: BorderRadius.circular(context.radiusMD),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.yourSkills,
              style: context.infoHeaderStyle
            ),
            SizedBox(height: context.spaceBtwFields),
            SelectableItemWrap(
              selectedItems: _controller.selectedItems,
              onDelete: (item) => _controller.removeItem(item, () => setState(() {})),
              onAdd: _showSkillBottomSheet,
              addLabel: AppStrings.addSkills,
            ),
          ],
        ),
      ),
    );
  }
}
