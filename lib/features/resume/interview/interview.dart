import 'package:flutter/material.dart';

import '../../../app/themes/text_styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';
import '../../widgets/back_button.dart';
import '../../widgets/profile_avatar.dart';

class InterView extends StatefulWidget {
  const InterView({super.key});

  @override
  State<InterView> createState() => _InterViewState();
}

class _InterViewState extends State<InterView> {
  String selectedCategory = 'Programming Languages';

  // Category Tabs
  final List<String> categories = [
    'Programming Languages',
    'Mobile Development',
    'Web Development',
    'Artificial Intelligence',
    'Blockchain',
    'DevOps',
    'Database Management',
    'Cloud Computing',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding:  EdgeInsets.all(AppSizes.lg),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleBackButton(pageColor: AppColors.blackLight),
                      Text("Select an Interview Template", style: AppTextStyles.featureTitle),
                      const ProfileAvatar(),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Category Filter Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((category) {
                        final bool isSelected = category == selectedCategory;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (_) => setState(() => selectedCategory = category),
                            selectedColor: Colors.black,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            backgroundColor: Colors.white,
                            shape: StadiumBorder(
                              side: BorderSide(color: Colors.grey.shade400),
                            ),
                            showCheckmark: false,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Interview Card Placeholder (Replace with your cards)
                  ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/templates/template1.jpeg', // replace with actual icons per card
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            'TypeScript Intermediate',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            'Advanced TS features, Decorators, Configuration, React integration...',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
