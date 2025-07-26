import 'package:flutter/material.dart';

import 'package:interview/core/extensions/responsive_extension.dart';
import 'package:interview/features/interview/models/interview_item.dart';
import 'package:interview/features/interview/screens/custom_interview/widgets/custom_topic.dart';
import 'package:interview/features/interview/screens/custom_interview/widgets/custom_topic_display.dart';
import 'package:interview/features/interview/screens/custom_interview/widgets/difficulty_selector.dart';
import 'package:interview/features/interview/screens/custom_interview/widgets/duration_selector.dart';
import 'package:interview/features/interview/screens/custom_interview/widgets/selected_topic_info.dart';
import 'package:interview/features/interview/screens/custom_interview/widgets/selection_title.dart';
import 'package:interview/features/interview/screens/custom_interview/widgets/topic_selector.dart';

import '../../../../app/themes/text_styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../helper/input_decoration_interview_helper.dart';

class CreateCustomInterviewBottomSheet extends StatefulWidget {
  final Function(InterviewItem) onInterviewCreated;

  const CreateCustomInterviewBottomSheet({
    super.key,
    required this.onInterviewCreated,
  });

  @override
  State<CreateCustomInterviewBottomSheet> createState() =>
      _CreateCustomInterviewBottomSheetState();
}

class _CreateCustomInterviewBottomSheetState
    extends State<CreateCustomInterviewBottomSheet> {
  // Controllers
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();
  final TextEditingController _customTopicController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // State variables
  String selectedDifficulty = 'Intermediate';
  String selectedDuration = '30 minutes';
  Set<String> selectedTopics = {};
  List<String> customTopics = [];

  //  ants
  final List<String> difficulties = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Expert',
  ];

  final List<String> durations = [
    '15 minutes',
    '30 minutes',
    '45 minutes',
    '60 minutes',
  ];

  final List<String> availableTopics = [
    'Data Structures',
    'Algorithms',
    'System Design',
    'Object-Oriented Programming',
    'Database Design',
    'API Development',
    'Testing',
    'Version Control',
    'Problem Solving',
    'Code Review',
    'Performance Optimization',
    'Security',
    'Architecture Patterns',
    'Debugging',
    'Clean Code',
  ];

  @override
  void dispose() {
    _jobTitleController.dispose();
    _companyController.dispose();
    _jobDescriptionController.dispose();
    _customTopicController.dispose();
    super.dispose();
  }

  // Business Logic Methods
  void _addCustomTopic() {
    final topic = _customTopicController.text.trim();
    if (topic.isNotEmpty && !customTopics.contains(topic)) {
      setState(() {
        customTopics.add(topic);
        selectedTopics.add(topic);
        _customTopicController.clear();
      });
    }
  }

  void _removeCustomTopic(String topic) {
    setState(() {
      customTopics.remove(topic);
      selectedTopics.remove(topic);
    });
  }

  void _onDifficultyChanged(String difficulty) {
    setState(() => selectedDifficulty = difficulty);
  }

  void _onDurationChanged(String duration) {
    setState(() => selectedDuration = duration);
  }

  void _onTopicsChanged(Set<String> newSelectedTopics) {
    setState(() => selectedTopics = newSelectedTopics);
  }

  void _createInterview() {
    if (_formKey.currentState!.validate() && selectedTopics.isNotEmpty) {
      final interviewItem = InterviewItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        jobTitle: _jobTitleController.text,
        company: _companyController.text.isEmpty
            ? 'Custom Company'
            : _companyController.text,
        jobDescription: _jobDescriptionController.text,
        difficulty: selectedDifficulty,
        duration: selectedDuration,
        topics: selectedTopics.toList(),
        isCustom: true,
        createdAt: DateTime.now(),
      );

      widget.onInterviewCreated(interviewItem);
      Navigator.of(context).pop();
    } else if (selectedTopics.isEmpty) {
      _showTopicsRequiredSnackBar();
    }
  }

  void _showTopicsRequiredSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppStrings.selectAtLeastOneTopic),
        backgroundColor: AppColors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: context.sheetInitialSize,
      minChildSize: context.sheetMinSize,
      maxChildSize: context.sheetMaxSize,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundLightBlue,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(context.radiusLG),
            ),
          ),
          child: Column(
            children: [
              _buildHandle(),
              _buildHeader(),
              _buildContent(scrollController),
              _buildCreateButton(),
            ],
          ),
        );
      },
    );
  }

  // UI Building Methods
  Widget _buildHandle() {
    return Container(
      margin: EdgeInsets.only(top: context.sm),
      width: context.handleWidth,
      height: context.handleHeight,
      decoration: BoxDecoration(
        color: AppColors.grey300,
        borderRadius: BorderRadius.circular(context.radiusXS),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(context.paddingLG),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppStrings.createCustomInterview,
              style: AppTextStyles.header(context),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(ScrollController scrollController) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: EdgeInsets.all(context.paddingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildJobTitleSection(),
              SizedBox(height: context.spaceBtwItemsH),
              _buildCompanySection(),
              SizedBox(height: context.spaceBtwItemsH),
              _buildJobDescriptionSection(),
              SizedBox(height: context.spaceBtwItemsH),
              _buildDifficultySection(),
              SizedBox(height: context.spaceBtwItemsH),
              _buildDurationSection(),
              SizedBox(height: context.spaceBtwItemsH),
              _buildTopicsSection(),
              SizedBox(height: context.spaceBtwItemsH),
              _buildCustomTopicSection(),
              SizedBox(height: context.spaceBtwItemsH),
              _buildTopicsInfoSection(),
              SizedBox(height: context.extraSpacingForButton),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: AppStrings.jobTitleLabel),
        TextFormField(
          controller: _jobTitleController,
          decoration: InputDecorationHelper.buildInputDecoration(
            AppStrings.jobTitleHint,
            context,
          ),
          validator: (value) =>
              value?.isEmpty == true ? AppStrings.jobTitleValidation : null,
        ),
      ],
    );
  }

  Widget _buildCompanySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: AppStrings.companyLabel),
        TextFormField(
          controller: _companyController,
          decoration: InputDecorationHelper.buildInputDecoration(
            AppStrings.companyHint,
            context,
          ),
        ),
      ],
    );
  }

  Widget _buildJobDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: AppStrings.jobDescriptionLabel),
        TextFormField(
          controller: _jobDescriptionController,
          maxLines: context.textFieldMaxLines.toInt(),
          decoration: InputDecorationHelper.buildInputDecoration(
            AppStrings.jobDescriptionHint,
            context,
          ),
          validator: (value) => value?.isEmpty == true
              ? AppStrings.jobDescriptionValidation
              : null,
        ),
      ],
    );
  }

  Widget _buildDifficultySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: AppStrings.difficultyLevel),
        DifficultySelectionWidget(
          selectedDifficulty: selectedDifficulty,
          difficulties: difficulties,
          onDifficultyChanged: _onDifficultyChanged,
        ),
      ],
    );
  }

  Widget _buildDurationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: AppStrings.interviewDuration),
        DurationSelectionWidget(
          selectedDuration: selectedDuration,
          durations: durations,
          onDurationChanged: _onDurationChanged,
        ),
      ],
    );
  }

  Widget _buildTopicsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: AppStrings.interviewTopicsLabel),
        Text(
          AppStrings.interviewTopicsHint,
          style: AppTextStyles.hintTextGrey(context),
        ),
        SizedBox(height: context.sm),
        TopicsSelectionWidget(
          availableTopics: availableTopics,
          selectedTopics: selectedTopics,
          onTopicsChanged: _onTopicsChanged,
        ),
      ],
    );
  }

  Widget _buildCustomTopicSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTopicInputWidget(
          controller: _customTopicController,
          onAddTopic: _addCustomTopic,
        ),
        CustomTopicsDisplayWidget(
          customTopics: customTopics,
          onRemoveTopic: _removeCustomTopic,
        ),
      ],
    );
  }

  Widget _buildTopicsInfoSection() {
    return TopicsInfoWidget(selectedTopicsCount: selectedTopics.length);
  }

  Widget _buildCreateButton() {
    return Container(
      padding: EdgeInsets.all(context.paddingLG),
      decoration: BoxDecoration(color: AppColors.backgroundLightBlue),
      child: SizedBox(
        width: double.infinity,
        height: context.createButtonHeight,
        child: ElevatedButton(
          onPressed: _createInterview,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blackLight,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.radiusXL),
            ),
          ),
          child: Text(
            AppStrings.createInterview,
            style: AppTextStyles.buttonText(context),
          ),
        ),
      ),
    );
  }
}
