import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/image_strings.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import 'package:interview/features/interview/widgets/search_field.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../resume/screens/widgets/resume_builder_home_widgets/resume_form_top_bar.dart';

class MockInterviewScreen extends StatefulWidget {
  const MockInterviewScreen({super.key});

  @override
  State<MockInterviewScreen> createState() => _MockInterviewScreenState();
}

class _MockInterviewScreenState extends State<MockInterviewScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  String selectedCategory = 'Programming Languages';
  final List<String> recentSearches = [];

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

  final List<Map<String, dynamic>> mockInterviews = [
    {
      'title': 'Flutter Basics',
      'image': 'assets/images/flutter.png',
      'topics': ['Widgets', 'State Management'],
    },
    {
      'title': 'Web Development',
      'image': 'assets/images/web.png',
      'topics': ['HTML', 'CSS', 'JS'],
    },
    {
      'title': 'AI & ML',
      'image': 'assets/images/ai.png',
      'topics': ['Supervised', 'Unsupervised'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.all(context.lg),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResumeFormTopBar(
                    pageColor: AppColors.blackLight,
                    title: AppStrings.mockInterview,
                  ),
                  const SizedBox(height: 16),
                  SearchField(
                    controller: _searchController,
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
                      setState(() {
                        _searchText = value;
                        if (value.isNotEmpty && !recentSearches.contains(value)) {
                          recentSearches.add(value);
                        }
                      });
                    },
                  ),
                  if (_searchText.isNotEmpty) ...[
                    const SizedBox(height: 16),
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
                  if (recentSearches.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Recent Searches',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: recentSearches.map((search) {
                        return InputChip(
                          label: Text(search),
                          onPressed: () {
                            setState(() {
                              _searchText = search;
                              _searchController.text = search;
                            });
                          },
                          onDeleted: () {
                            setState(() {
                              recentSearches.remove(search);
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 16),
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
                            onSelected: (_) =>
                                setState(() => selectedCategory = category),
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: mockInterviews.length,
                    itemBuilder: (context, index) {
                      final item = mockInterviews[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              AppImage.temp3,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(item['title'] as String),
                          subtitle: const Text('Tap to start interview'),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                          onTap: () {
                            context.pushNamed(
                              'takeInterview',
                              extra: {
                                'title': item['title'],
                                'topics': item['topics'],
                              },
                            );
                          },
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
