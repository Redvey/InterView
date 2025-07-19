import 'package:flutter/material.dart';
import 'package:interview/features/flash_card/services/questions_service.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../core/constants/strings.dart';
import '../resume/screens/widgets/resume_builder_home_widgets/resume_form_top_bar.dart';
import '../resume/widgets/final_step_dialog.dart';

class FlashCard extends StatefulWidget {
  const FlashCard({super.key});

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  String? selectedTopic;

  final List<String> programmingLanguages = [
    'Python', 'Java', 'Javascript', 'C++', 'C#', 'Ruby', 'Swift',
    'Kotlin', 'Go', 'Rust', 'TypeScript', 'PHP', 'HTML', 'CSS',
  ];

  final List<String> mobileDevelopment = [
    'React Native', 'Flutter', 'iOS SDK', 'Android SDK',
  ];

  final List<String> webDevelopment = [
    'MERN', 'Node.js', 'Next.js', 'React', 'Angular', 'Vue.js',
    'Django', 'Flask', 'Ruby on Rails', 'Express.js', 'Spring Boot', 'Laravel',
  ];

  // Function to show confirmation dialog and navigate
  void _showTopicConfirmationDialog(String topic) {
    // Check if questions are available for this topic
    final questionCount = QuestionService.getTotalQuestionsForTopic(topic);

    if (questionCount == 0) {
      _showNoQuestionsDialog(topic);
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FinalStepDialog(
          title: 'Ready for $topic revision?',
          subTitle: '$questionCount questions available',
          yes: AppStrings.alertStart,
          no: AppStrings.alertCancel,
          navigate: '/quiz/$topic',
        );
      },
    );
  }

  // Show dialog when no questions are available
  void _showNoQuestionsDialog(String topic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FinalStepDialog(
          title: 'No Questions Available',
          subTitle: 'Sorry, we don\'t have questions for $topic yet. Please try another topic.',
          yes: 'OK',
          no: '',
          navigate: '', // Empty navigate means it will just close
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.all(AppSizes.lg(context)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  ResumeFormTopBar(
                      pageColor: AppColors.blackLight,
                      title: AppStrings.flashcard
                  ),
                  const SizedBox(height: 16),

                  const Text(
                      "Practice Cards",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      )
                  ),
                  const SizedBox(height: 12),

                  _buildTopicSection(
                      "Programming Languages",
                      programmingLanguages
                  ),

                  const SizedBox(height: 16),
                  _buildTopicSection(
                      "Mobile Development",
                      mobileDevelopment
                  ),

                  const SizedBox(height: 16),
                  _buildTopicSection(
                      "Web Development",
                      webDevelopment
                  ),

                  const SizedBox(height: 20),
                  _buildAvailableTopicsInfo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build topic sections
  Widget _buildTopicSection(String title, List<String> topics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.blackLight,
            )
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: topics.map((topic) => _buildChip(
              topic,
              selectedTopic,
                  (val) {
                setState(() => selectedTopic = val);
                _showTopicConfirmationDialog(val);
              }
          )).toList(),
        ),
      ],
    );
  }

  // Build info section showing available topics
  Widget _buildAvailableTopicsInfo() {
    final availableTopics = QuestionService.getAllTopics();

    if (availableTopics.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withAlpha(65)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue, size: 20),
              SizedBox(width: 8),
              Text(
                'Available Topics',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: availableTopics.map((topic) {
              final count = QuestionService.getTotalQuestionsForTopic(topic);
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(25),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.withAlpha(65)),
                ),
                child: Text(
                  '$topic ($count)',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Build individual chip widget
  Widget _buildChip(String label, String? selectedValue, Function(String) onSelected) {
    final bool isSelected = selectedValue == label;
    final bool hasQuestions = QuestionService.getTotalQuestionsForTopic(label) > 0;

    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          if (hasQuestions) ...[
            const SizedBox(width: 4),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onSelected(label),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
      ),
      selectedColor: AppColors.blackLight,
      backgroundColor: hasQuestions ? Colors.white : Colors.grey[300],
      disabledColor: Colors.grey[300],
      shape: StadiumBorder(
          side: BorderSide(
              color: isSelected
                  ? AppColors.blackLight
                  : hasQuestions
                  ? Colors.grey.shade400
                  : Colors.grey.shade300
          )
      ),
      showCheckmark: false,
      elevation: isSelected ? 2 : 0,
      pressElevation: 4,
    );
  }
}