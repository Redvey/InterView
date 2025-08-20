import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_three/widgets/category_tab.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_three/widgets/skill_chip.dart';

import '../../../../../../core/constants/strings.dart';
import 'data/skill_categories.dart';


class StepThreeSkills extends StatefulWidget {
  final Map<String, dynamic> initialData;
  final Function(Map<String, dynamic>) onDataChanged;

  const StepThreeSkills({
    super.key,
    required this.initialData,
    required this.onDataChanged,
  });

  @override
  State<StepThreeSkills> createState() => _StepThreeSkillsState();
}

class _StepThreeSkillsState extends State<StepThreeSkills> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _locationController = TextEditingController();

  List<String> _selectedSkills = [];
  String _selectedCategory = AppStrings.categoryProgramming;

  static const int maxSelection = 10;

  @override
  void initState() {
    super.initState();
    _selectedSkills = List<String>.from(widget.initialData['skills'] ?? []);
    _usernameController.text = widget.initialData['username'] ?? '';
    _locationController.text = widget.initialData['location'] ?? '';

    _usernameController.addListener(_updateData);
    _locationController.addListener(_updateData);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _updateData() {
    widget.onDataChanged({
      'skills': _selectedSkills,
      'skillCategory': _selectedCategory,
      'username': _usernameController.text,
      'location': _locationController.text,
    });
  }

  void _toggleSkill(String skill) {
    setState(() {
      if (_selectedSkills.contains(skill)) {
        _selectedSkills.remove(skill);
      } else {
        if (_selectedSkills.length < maxSelection) {
          _selectedSkills.add(skill);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppStrings.skillLimitMessage(maxSelection),
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColors.warning,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      }
    });
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: context.lg),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.spaceBtwFields),

            // Header
            Text(
              AppStrings.yourSkillsExpertise,
              style: context.headingStyle(color: AppColors.black87),
            ),
            SizedBox(height: context.sm),
            Text(
              AppStrings.selectSkillsDescription(maxSelection),
              style: context.subheadingStyle(color: AppColors.textGrey),
            ),

            SizedBox(height: context.spaceBtwSections),

                Text(
                  'Filter by Category',
                  style: context.bodyBoldStyle.copyWith(fontSize: context.fontSizeSms,color: AppColors.purple),
                ),


            SizedBox(height: context.spaceBtwFields),
            // Category tabs
            SizedBox(
              height: context.spaceBtwSections,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: skillCategories.keys.length,
                itemBuilder: (context, index) {
                  final category = skillCategories.keys.elementAt(index);
                  return Padding(
                    padding: EdgeInsets.only(right: context.sm),
                    child: CategoryTab(
                      category: category,
                      isSelected: _selectedCategory == category,
                      onTap: () {
                        setState(() => _selectedCategory = category);
                      },
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: context.spaceBtwFields),

            // Selected count + Clear All
            Row(
              children: [
                Text(
                  AppStrings.selectedCount(_selectedSkills.length, maxSelection),
                  style: context.bodyBoldStyle.copyWith(fontSize: context.fontSizeSms,color: _selectedSkills.length >= maxSelection
                  ? AppColors.warning
                    : AppColors.success,),

                ),
                const Spacer(),
                if (_selectedSkills.isNotEmpty)
                  InkWell(
                    onTap: () {
                      setState(() => _selectedSkills.clear());
                      _updateData();
                    },
                    child: Text(
                      AppStrings.clearAll,
                      style: context.bodyBoldStyle.copyWith(fontSize: context.fontSizeSms,color: AppColors.red),
                    ),
                  ),
              ],
            ),

            SizedBox(height: context.spaceBtwFields),

            // Skills
            Wrap(
              children: skillCategories[_selectedCategory]!
                  .map((skill) => SkillChip(
                skill: skill,
                isSelected: _selectedSkills.contains(skill),
                onTap: () => _toggleSkill(skill),
              ))
                  .toList(),
            ),

            SizedBox(height: context.spaceBtwSections),

            // Selected preview
            if (_selectedSkills.isNotEmpty) ...[
              Text(
                AppStrings.yourSelectedSkills,
                style: context.sectionTitleStyle,
              ),
              SizedBox(height: context.spaceBtwFields),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(context.paddingMD),
                decoration: BoxDecoration(
                  color: AppColors.backgroundYellow,
                  borderRadius: BorderRadius.circular(context.radiusMD),
                  border: Border.all(
                    color: AppColors.buttonYellow,
                    width: context.borderWidthThin,
                  ),
                ),
                child: Wrap(
                  children: _selectedSkills
                      .map((skill) => Container(
                    margin: EdgeInsets.only(
                      right: context.xs,
                      bottom: context.xs,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.paddingSM,
                      vertical: context.paddingXS,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.buttonYellow,
                      borderRadius: BorderRadius.circular(context.radiusSM),
                    ),
                    child: Text(
                      skill,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],

            SizedBox(height: context.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
