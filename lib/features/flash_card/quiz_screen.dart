import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/image_strings.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import 'package:interview/features/flash_card/services/questions_service.dart';
import 'package:interview/features/flash_card/widgets/question_card.dart';
import 'package:interview/features/flash_card/widgets/quiz_action_button.dart';
import 'package:interview/features/flash_card/widgets/quiz_appbar.dart';
import 'package:interview/features/flash_card/widgets/quiz_completion.dart';
import 'package:interview/features/flash_card/widgets/quiz_stats.dart';
import 'models/question.dart';

class QuizScreen extends StatefulWidget {
  final String topic;

  const QuizScreen({super.key, required this.topic});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Question> questions;
  int currentQuestionIndex = 0;
  int inReview = 0;
  int done = 0;
  bool showAnswer = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    setState(() {
      questions = QuestionService.getQuestionsForTopic(widget.topic);
      inReview = questions.length;
      isLoading = false;
    });
  }

  void _toggleAnswer() {
    setState(() {
      showAnswer = !showAnswer;
    });
  }

  void _markAsKnown() {
    setState(() {
      if (inReview > 0) {
        inReview--;
        done++;
      }
      _nextQuestion();
    });
  }

  void _markAsUnknown() {
    // Keep in review, just move to next
    _nextQuestion();
  }

  void _nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        showAnswer = false;
      } else {
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => QuizCompletionDialog(
        topic: widget.topic,
        done: done,
        inReview: inReview,
        onBackToTopics: () {
          Navigator.of(context).pop();
          context.pop();
        },
        onRestartQuiz: () {
          Navigator.of(context).pop();
          _restartQuiz();
        },
      ),
    );
  }

  void _restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      inReview = questions.length;
      done = 0;
      showAnswer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    if (questions.isEmpty) {
      return _buildEmptyState();
    }

    final currentQuestion = questions[currentQuestionIndex];
    final totalQuestions = questions.length;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(AppImage.temp3)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: Padding(
                padding: context.screenPadding,
                child: Column(
                  children: [
                    QuizAppBar(
                      currentIndex: currentQuestionIndex + 1,
                      totalQuestions: totalQuestions,
                      onRestart: _restartQuiz,
                      onBackToTopics: () => context.pop(),
                    ),
                    SizedBox(height: 12,),
                    // Topic Title
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.white.withAlpha(128),
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        color: Colors.white.withAlpha(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(25),
                            offset: const Offset(0, 7.62),
                            blurRadius: 22.85,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Text(
                        widget.topic.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 16),

                    QuizStatsRow(inReview: inReview, done: done),

                    const SizedBox(height: 32),

                    Expanded(
                      child: QuizQuestionCard(
                        question: currentQuestion,
                        showAnswer: showAnswer,
                      ),
                    ),



                    // QuizActionButtons(
                    //   showAnswer: showAnswer,
                    //   onToggleAnswer: _toggleAnswer,
                    //   onMarkAsKnown: _markAsKnown,
                    //   onMarkAsUnknown: _markAsUnknown,
                    // ),
                  ],
                ),
              ),
            ),
            QuizActionButtons(
                showAnswer: showAnswer,
                onToggleAnswer: _toggleAnswer,
                onMarkAsKnown: _markAsKnown,
              onMarkAsUnknown: _markAsUnknown,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(widget.topic, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.quiz_outlined, color: Colors.grey, size: 64),
            const SizedBox(height: 16),
            Text(
              'No questions available for ${widget.topic}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              child: const Text('Back to Topics'),
            ),
          ],
        ),
      ),
    );
  }

}


