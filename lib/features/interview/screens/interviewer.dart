import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/app/routes/route_names.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/image_strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/widgets/back_button.dart';

import 'interviewer/widgets/camera_feed_widget.dart';
import 'interviewer/widgets/control_buttons.dart';
import 'interviewer/widgets/interview_state.dart';
import 'interviewer/widgets/question_panel.dart';


class InterviewerScreen extends StatefulWidget {
  const InterviewerScreen({super.key});

  @override
  InterviewerScreenState createState() => InterviewerScreenState();
}

class InterviewerScreenState extends State<InterviewerScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _glowController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _glowAnimation;

  late InterviewState _interviewState;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _interviewState = InterviewState(
      currentQuestion: 2,
      totalQuestions: 5,
      confidenceScore: 78,
      eyeContact: "Maintained",
      posture: "Good",
      isRecording: false,
    );
  }

  void _setupAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    setState(() {
      _interviewState = _interviewState.copyWith(
        isRecording: !_interviewState.isRecording,
      );
    });
  }

  void _endInterview() {
    context.pushNamed(RouteNames.finishInterview);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        // gradient: AppColors.interviewer
        image: DecorationImage(image: AssetImage(AppImage.temp3),fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(context.paddingLG),
            child: Column(
              children: [
                // Header with timer and status
                _buildHeader(),
                SizedBox(height: context.defaultSpaceH),

                // Camera feed taking most space
                Expanded(
                  flex: 2,
                  child: CameraFeedWidget(
                    confidenceScore: _interviewState.confidenceScore,
                    glowAnimation: _glowAnimation,
                  ),
                ),

                SizedBox(height: context.defaultSpaceH),

                // Bottom content
                Flexible(
                  flex: 1,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        QuestionPanel(
                          currentQuestion: _interviewState.currentQuestion,
                          totalQuestions: _interviewState.totalQuestions,
                          questionText: "Kyun nahi hori padhai?",
                        ),
                        SizedBox(height: context.defaultSpaceH),
                        ControlButtons(
                          isRecording: _interviewState.isRecording,
                          pulseAnimation: _pulseAnimation,
                          onToggleRecording: _toggleRecording,
                          onEndInterview: _endInterview,
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleBackButton(pageColor: AppColors.backgroundBlue),
        Container(
          width: context.screenWidth/2,
          padding: EdgeInsets.symmetric(
              horizontal: context.paddingXL,
              vertical: context.paddingMD
          ),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(76),
            borderRadius: BorderRadius.circular(context.radiusXL),
            border: Border.all(
              color: Colors.white.withAlpha(51),
              width: context.borderWidthThin,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: context.xs,
                    height: context.xs,
                    decoration: BoxDecoration(
                      color: _interviewState.isRecording ? Colors.red : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: context.xs),
                  Text(
                    _interviewState.isRecording ? 'Recording' : 'Paused',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: context.fontSizeSm,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: context.paddingMD,
                    vertical: context.paddingXS
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  borderRadius: BorderRadius.circular(context.radiusSM),
                ),
                child: Text(
                  '12:34',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.fontSizeSm,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}