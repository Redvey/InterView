import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:interview/core/constants/app_durations.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import 'package:interview/features/interview/screens/custom_interview/custom_interview.dart';
import 'package:interview/features/interview/services/interview_dummy_data_service.dart';
import 'package:interview/features/interview/widgets/search_field.dart';
import 'package:interview/features/interview/widgets/interview_card.dart';
import 'package:interview/features/interview/models/interview_item.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../app/routes/route_names.dart';
import '../resume/screens/widgets/resume_builder_home_widgets/resume_form_top_bar.dart';

class MockInterviewScreen extends StatefulWidget {
  const MockInterviewScreen({super.key});

  @override
  State<MockInterviewScreen> createState() => _MockInterviewScreenState();
}

class _MockInterviewScreenState extends State<MockInterviewScreen> {
  final TextEditingController _searchController = TextEditingController();
  final InterviewDataService _dataService = InterviewDataService();

  String _searchText = '';
  String selectedCategory = 'Programming Languages';
  List<String> recentSearches = [];
  List<InterviewItem> interviewItems = [];
  List<InterviewItem> filteredItems = [];
  bool isLoading = true;

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
  void initState() {
    super.initState();
    _loadInterviewItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadInterviewItems() async {
    setState(() => isLoading = true);

    try {
      final items = await _dataService.getInterviewItems(
        category: selectedCategory,
        searchQuery: _searchText.isEmpty ? null : _searchText,
      );

      setState(() {
        interviewItems = items;
        filteredItems = items;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('Error loading interview items: $e');
    }
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchText = value;
      if (value.isNotEmpty && !recentSearches.contains(value)) {
        recentSearches.insert(0, value);
        if (recentSearches.length > 5) {
          recentSearches = recentSearches.take(5).toList();
        }
      }
    });

    _filterItems();
  }

  void _onCategoryChanged(String category) {
    setState(() {
      selectedCategory = category;
    });
    _loadInterviewItems();
  }

  void _filterItems() {
    if (_searchText.isEmpty) {
      setState(() {
        filteredItems = interviewItems;
      });
      return;
    }

    setState(() {
      filteredItems = interviewItems.where((item) =>
      item.jobTitle.toLowerCase().contains(_searchText.toLowerCase()) ||
          item.jobDescription.toLowerCase().contains(_searchText.toLowerCase()) ||
          item.topics.any((topic) =>
              topic.toLowerCase().contains(_searchText.toLowerCase()))).toList();
    });
  }

  void _onInterviewCardTap(InterviewItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${AppStrings.starting} ${item.jobTitle} ${AppStrings.interviewStart}'),

        duration: const Duration(seconds: AppDurations.interviewStartDelaySeconds),
      ),
    );
  }

  void _onRecentSearchTap(String search) {
    setState(() {
      _searchText = search;
      _searchController.text = search;
    });
    _filterItems();
  }

  void _onRecentSearchDelete(String search) {
    setState(() {
      recentSearches.remove(search);
    });
  }

  void _showCreateInterviewBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateCustomInterviewBottomSheet(
        onInterviewCreated: (InterviewItem interview) {
          // Handle the created interview
          _onInterviewCardTap(interview);

          // Add it to the local list
          setState(() {
            interviewItems.insert(0, interview);
            _filterItems();
          });

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppStrings.interviewCreated(interview.jobTitle))
              ,
              backgroundColor: AppColors.textGreen,
              duration:  Duration(seconds: AppDurations.interviewCountdownSeconds),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      child: SafeArea(
        bottom: true,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.all(context.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar
                ResumeFormTopBar(
                  pageColor: AppColors.blackLight,
                  title: AppStrings.mockInterview,
                ),

                SizedBox(height: context.spaceBtwItemsH),

                // Search Field
                SearchField(
                  controller: _searchController,
                  hintText: AppStrings.searchHint,
                  borderRadius: context.borderRadiusLx,
                  fillColor: AppColors.searchFill,
                  borderColor: AppColors.searchBorder,
                  focusedBorderColor: AppColors.searchFocused,
                  hintStyle: AppTextStyles.searchHint(context),
                  textStyle:  AppTextStyles.noInterviewsFound(context),
                  onChanged: _onSearchChanged,
                ),

                SizedBox(height: context.spaceBtwItemsH),

                // Recent Searches
                if (recentSearches.isNotEmpty) ...[
                  Text(
                    AppStrings.recentSearches,
                    style: AppTextStyles.searchHint(context),
                  ),

                  SizedBox(height: context.spaceLess),

                  SizedBox(
                    height: context.bottomNavBottomPadding,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recentSearches.length,
                      itemBuilder: (context, index) {
                        final search = recentSearches[index];
                        return Padding(
                          padding: context.horizontalPadding,
                          child: InputChip(
                            label: Text(search),
                            onPressed: () => _onRecentSearchTap(search),
                            onDeleted: () => _onRecentSearchDelete(search),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: context.spaceBtwItemsH),
                ],

                // Category Chips
                SizedBox(
                  height: context.bottomNavBottomPadding,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = category == selectedCategory;

                      return Padding(
                        padding: EdgeInsets.only(right: context.spaceLess),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (_) => _onCategoryChanged(category),
                          selectedColor: AppColors.blackLight,
                          labelStyle: AppTextStyles.labelStyleCategory(context, isSelected),
                          backgroundColor: AppColors.backgroundWhite,
                          shape: StadiumBorder(
                            side: BorderSide(color: AppColors.textGrey),
                          ),
                          showCheckmark: false,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: context.spaceBtwFields),

                // Interview Items List
                Expanded(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : filteredItems.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return InterviewCard(
                        interviewItem: item,
                        onTap: ()=>context.pushNamed(RouteNames.interviewer),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _showCreateInterviewBottomSheet,
            backgroundColor: AppColors.blackLight,
            foregroundColor: AppColors.textGreen,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: context.iconSize,
            color: AppColors.textGrey,
          ),
          SizedBox(height: context.spaceBtwItems),
          Text(
            _searchText.isNotEmpty
                ? '${AppStrings.noInterviewsFound} "$_searchText"'
                : '${AppStrings.noInterviewsAvailable} "$selectedCategory"',
            style: AppTextStyles.noInterviewsFound(context),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.spaceLessH),
          Text(
            AppStrings.adjustCategory,
            style: AppTextStyles.emptyStateHint(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
