import 'package:flutter/material.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/features/interview/models/interview_item.dart';
import '../../../core/constants/colors.dart';


class CreateCustomInterviewBottomSheet extends StatefulWidget {
  final Function(InterviewItem) onInterviewCreated;

  const CreateCustomInterviewBottomSheet({
    super.key,
    required this.onInterviewCreated,
  });

  @override
  State<CreateCustomInterviewBottomSheet> createState() => _CreateCustomInterviewBottomSheetState();
}

class _CreateCustomInterviewBottomSheetState extends State<CreateCustomInterviewBottomSheet> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _jobDescriptionController = TextEditingController();
  final TextEditingController _customTopicController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String selectedDifficulty = 'Intermediate';
  String selectedDuration = '30 minutes';
  Set<String> selectedTopics = {};
  List<String> customTopics = [];

  final List<String> difficulties = ['Beginner', 'Intermediate', 'Advanced', 'Expert'];
  final List<String> durations = ['15 minutes', '30 minutes', '45 minutes', '60 minutes'];

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

  void _createInterview() {
    if (_formKey.currentState!.validate() && selectedTopics.isNotEmpty) {
      final interviewItem = InterviewItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        jobTitle: _jobTitleController.text,
        company: _companyController.text.isEmpty ? 'Custom Company' : _companyController.text,
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.selectAtLeastOneTopic),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            gradient: AppColors.backgroundGradient,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.createCustomInterview,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),



              // Content
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Job Title Field
                        _buildSectionTitle(AppStrings.jobTitleLabel),
                        TextFormField(
                          controller: _jobTitleController,
                          decoration: _buildInputDecoration(AppStrings.jobTitleHint),
                          validator: (value) => value?.isEmpty == true ? AppStrings.jobTitleValidation : null,
                        ),

                        const SizedBox(height: 20),

                        // Company Field
                        _buildSectionTitle(AppStrings.companyLabel),
                        TextFormField(
                          controller: _companyController,
                          decoration: _buildInputDecoration(AppStrings.companyHint),
                        ),

                        const SizedBox(height: 20),

                        // Job Description Field
                        _buildSectionTitle(AppStrings.jobDescriptionLabel),
                        TextFormField(
                          controller: _jobDescriptionController,
                          maxLines: 4,
                          decoration: _buildInputDecoration(AppStrings.jobDescriptionHint),
                          validator: (value) => value?.isEmpty == true ? AppStrings.jobDescriptionValidation : null,
                        ),

                        const SizedBox(height: 20),

                        // Difficulty Selection
                        _buildSectionTitle(AppStrings.difficultyLevel),
                        Wrap(
                          spacing: 8,
                          children: difficulties.map((difficulty) {
                            final isSelected = selectedDifficulty == difficulty;
                            return ChoiceChip(
                              label: Text(difficulty),
                              selected: isSelected,
                              onSelected: (_) => setState(() => selectedDifficulty = difficulty),
                              selectedColor: AppColors.blackLight,
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              backgroundColor: AppColors.backgroundWhite,
                              shape: const StadiumBorder(
                                side: BorderSide(color: AppColors.textGrey),
                              ),
                              showCheckmark: false,
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),

                        // Duration Selection
                        _buildSectionTitle(AppStrings.interviewDuration),
                        Wrap(
                          spacing: 8,
                          children: durations.map((duration) {
                            final isSelected = selectedDuration == duration;
                            return ChoiceChip(
                              label: Text(duration),
                              selected: isSelected,
                              onSelected: (_) => setState(() => selectedDuration = duration),
                              selectedColor: AppColors.blackLight,
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              backgroundColor: Colors.white,
                              shape: StadiumBorder(
                                side: BorderSide(color: Colors.grey.shade400),
                              ),
                              showCheckmark: false,
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),

                        // Topics Selection
                        _buildSectionTitle(AppStrings.interviewTopicsLabel),
                        const Text(
                          AppStrings.interviewTopicsHint,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: availableTopics.map((topic) {
                            final isSelected = selectedTopics.contains(topic);
                            return FilterChip(
                              label: Text(topic),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    selectedTopics.add(topic);
                                  } else {
                                    selectedTopics.remove(topic);
                                  }
                                });
                              },
                              selectedColor: AppColors.textGreen.withAlpha(51),
                              checkmarkColor: AppColors.textGreen,
                              labelStyle: TextStyle(
                                color: isSelected ? AppColors.textGreen : Colors.black,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 16),

                        // Custom Topics
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _customTopicController,
                                decoration: _buildInputDecoration(AppStrings.addCustomTopicHint),
                                onFieldSubmitted: (_) => _addCustomTopic(),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: _addCustomTopic,
                              icon: const Icon(Icons.add_circle),
                              color: AppColors.textGreen,
                            ),
                          ],
                        ),

                        // Custom Topics Display
                        if (customTopics.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: customTopics.map((topic) {
                              return Chip(
                                label: Text(topic),
                                deleteIcon: const Icon(Icons.close, size: 18),
                                onDeleted: () => _removeCustomTopic(topic),
                                backgroundColor: AppColors.textGreen.withAlpha(26),
                                labelStyle: const TextStyle(color: AppColors.textGreen),
                              );
                            }).toList(),
                          ),
                        ],

                        const SizedBox(height: 20),

                        // Selected Topics Count
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.blue[600], size: 20),
                              const SizedBox(width: 8),
                              Text(
                                '${selectedTopics.length} ${AppStrings.topicsSelected}',
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 100), // Extra space for button
                      ],
                    ),
                  ),
                ),
              ),

              // Create Button - Fixed at bottom
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.backgroundYellow,

                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _createInterview,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blackLight,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      AppStrings.createInterview,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[500]),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.blackLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}