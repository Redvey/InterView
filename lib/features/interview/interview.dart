import 'package:flutter/material.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import 'package:interview/features/interview/widgets/search_field.dart';

import '../../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../resume/screens/widgets/resume_builder_home_widgets/resume_form_top_bar.dart';


class MockInterviewScreen extends StatefulWidget {
  const MockInterviewScreen({super.key});

  @override
  State<MockInterviewScreen> createState() => _MockInterviewScreenState();
}

class _MockInterviewScreenState extends State<MockInterviewScreen> {
  final TextEditingController _searchController = TextEditingController();
  final String _searchText = '';
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
            padding:  EdgeInsets.all( context.lg),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  ResumeFormTopBar(pageColor: AppColors.blackLight, title: AppStrings.mockInterview,),


                  const SizedBox(height: 16),
                  SearchField(
                    hintText: 'Search with custom style...',
                    borderRadius: 20,
                    fillColor: Colors.blue[50],
                    borderColor: Colors.blue[200],
                    focusedBorderColor: Colors.blue,
                    hintStyle: TextStyle(
                      color: Colors.blue[400],
                      fontSize: 14,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (value) {
                      print('Custom search: $value');
                    },
                  ),
                  if (_searchText.isNotEmpty) ...[
                    const Text(
                      'Search Results:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Searching for: "$_searchText"',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
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
