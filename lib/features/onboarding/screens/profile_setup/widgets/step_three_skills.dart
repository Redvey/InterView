// step_three_skills.dart
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../core/constants/colors.dart';

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
  // Form key and controllers
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _locationController = TextEditingController();

  // Skills state
  List<String> _selectedSkills = [];
  String _selectedCategory = 'Programming';

  final Map<String, List<String>> _skillCategories = {
    'Programming': [
      'Flutter', 'Dart', 'JavaScript', 'Python', 'Java', 'C++', 'React', 'Node.js',
      'Swift', 'Kotlin', 'TypeScript', 'Go', 'Rust', 'C#', 'PHP', 'Ruby'
    ],
    'Design': [
      'UI/UX Design', 'Figma', 'Adobe XD', 'Photoshop', 'Illustrator', 'Sketch',
      'InVision', 'Canva', 'Wireframing', 'Prototyping', 'User Research', 'Design Systems'
    ],
    'Data': [
      'Data Analysis', 'SQL', 'Excel', 'Tableau', 'Power BI', 'R', 'Pandas',
      'Machine Learning', 'Statistics', 'Data Visualization', 'NumPy', 'Scikit-learn'
    ],
    'Marketing': [
      'Digital Marketing', 'SEO', 'SEM', 'Social Media', 'Content Marketing', 'Email Marketing',
      'Google Analytics', 'Facebook Ads', 'Brand Management', 'Market Research'
    ],
    'Business': [
      'Project Management', 'Agile', 'Scrum', 'Leadership', 'Strategy', 'Sales',
      'Business Analysis', 'Consulting', 'Operations', 'Finance', 'HR Management'
    ],
  };

  @override
  void initState() {
    super.initState();
    // Initialize with existing data
    _selectedSkills = List<String>.from(widget.initialData['skills'] ?? []);
    _usernameController.text = widget.initialData['username'] ?? '';
    _locationController.text = widget.initialData['location'] ?? '';

    // Add listeners to text controllers
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
        // Assuming maxSelection is 10 if not available in context
        final maxSelection = 10; // You can get this from context if available
        if (_selectedSkills.length < maxSelection) {
          _selectedSkills.add(skill);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'You can select up to $maxSelection skills',
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

  Widget _buildSkillChip(String skill) {
    final isSelected = _selectedSkills.contains(skill);

    return GestureDetector(
      onTap: () => _toggleSkill(skill),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(
          right: context.sm,
          bottom: context.sm,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingMD,
          vertical: context.paddingSM,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blackLight : AppColors.grey300,
          borderRadius: BorderRadius.circular(context.radiusLG),
          border: Border.all(
            color: isSelected ? AppColors.blackLight : AppColors.grey400,
            width: context.borderWidthThin,
          ),
        ),
        child: Text(
          skill,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTab(String category) {
    final isSelected = _selectedCategory == category;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingLG,
          vertical: context.paddingSM,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blackLight : Colors.transparent,
          borderRadius: BorderRadius.circular(context.radiusLG),
          border: Border.all(
            color: AppColors.blackLight,
            width: context.borderWidthThin,
          ),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.blackLight,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxSelection = 10; // Fallback value

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
              'Your Skills & Expertise',
              style: context.headingStyle(color: AppColors.black87),
            ),
            SizedBox(height: context.sm),
            Text(
              'Select up to $maxSelection skills that best represent your expertise',
              style: context.subheadingStyle(color: AppColors.textGrey),
            ),

            SizedBox(height: context.spaceBtwSections),

            // Username field
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Choose a unique username',
                prefixIcon: Icon(Icons.alternate_email, size: context.iconSizeMD),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.radiusMD),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.radiusMD),
                  borderSide: const BorderSide(color: AppColors.blackLight, width: 2),
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a username';
                }
                if (value!.length < 3) {
                  return 'Username must be at least 3 characters';
                }
                return null;
              },
            ),

            SizedBox(height: context.spaceBtwFields),

            // Location field
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                hintText: 'Enter your city, country',
                prefixIcon: Icon(Icons.location_on_outlined, size: context.iconSizeMD),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.radiusMD),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.radiusMD),
                  borderSide: const BorderSide(color: AppColors.blackLight, width: 2),
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your location';
                }
                return null;
              },
            ),

            SizedBox(height: context.spaceBtwSections),

            // Skills section header
            Text(
              'Select Your Skills',
              style: context.sectionTitleStyle,
            ),
            SizedBox(height: context.spaceBtwFields),

            // Category tabs
            SizedBox(
              height: 50, // Fixed height for category tabs
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _skillCategories.keys.length,
                itemBuilder: (context, index) {
                  final category = _skillCategories.keys.elementAt(index);
                  return Padding(
                    padding: EdgeInsets.only(right: context.sm),
                    child: _buildCategoryTab(category),
                  );
                },
              ),
            ),

            SizedBox(height: context.spaceBtwFields),

            // Selected skills count
            Row(
              children: [
                Text(
                  'Selected: ${_selectedSkills.length}/$maxSelection',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _selectedSkills.length >= maxSelection
                        ? AppColors.warning
                        : AppColors.success,
                  ),
                ),
                const Spacer(),
                if (_selectedSkills.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedSkills.clear();
                      });
                      _updateData();
                    },
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        color: AppColors.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: context.spaceBtwFields),

            // Skills grid
            Wrap(
              children: _skillCategories[_selectedCategory]!
                  .map((skill) => _buildSkillChip(skill))
                  .toList(),
            ),

            SizedBox(height: context.spaceBtwSections),

            // Selected skills preview
            if (_selectedSkills.isNotEmpty) ...[
              Text(
                'Your Selected Skills',
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