import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/image_strings.dart';
import 'package:interview/core/constants/strings.dart';
import 'dart:async';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

class InterviewPreparationDialog extends StatefulWidget {
  final VoidCallback onProceed;
  final VoidCallback? onCancel;

  const InterviewPreparationDialog({
    super.key,
    required this.onProceed,
    this.onCancel,
  });

  @override
  InterviewPreparationDialogState createState() => InterviewPreparationDialogState();

  // Static method to show the dialog
  static Future<void> show({
    required BuildContext context,
    required VoidCallback onProceed,
    VoidCallback? onCancel,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return InterviewPreparationDialog(
          onProceed: onProceed,
          onCancel: onCancel,
        );
      },
    );
  }
}

class InterviewPreparationDialogState extends State<InterviewPreparationDialog>
    with TickerProviderStateMixin {
  Timer? _timer;
  int _countdown = 30;
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _checklist = [
    {
      'icon': Icons.videocam,
      'title': 'Camera Position',
      'description': 'Look directly at the camera',
    },
    {
      'icon': Icons.light_mode,
      'title': 'Lighting',
      'description': 'Ensure good lighting, avoid dark rooms',
    },
    {
      'icon': Icons.volume_off,
      'title': 'Environment',
      'description': 'Find a quiet space without distractions',
    },
    {
      'icon': Icons.accessibility,
      'title': 'Posture',
      'description': 'Sit up straight and maintain good posture',
    },
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startCountdown();
  }

  void _setupAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _fadeController.forward();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer?.cancel();
        _proceedToInterview();
      }
    });
  }

  void _proceedToInterview() {
    _timer?.cancel();
    Navigator.of(context).pop();
    widget.onProceed();
  }

  void _skipTimer() {
    _timer?.cancel();
    _proceedToInterview();
  }

  void _cancelInterview() {
    _timer?.cancel();
    Navigator.of(context).pop();
    widget.onCancel?.call();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          decoration: BoxDecoration(
            // gradient: AppColors.interviewer,
            image: DecorationImage(image: AssetImage(AppImage.temp2),fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(context.paddingXXL),
            border: Border.all(
              color: Colors.white.withAlpha(51), // 0.2 * 255 = 51
              width: context.borderWidthThin,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(77), // 0.3 * 255 = 76.5 ≈ 77
                blurRadius: context.paddingXL,
                spreadRadius: context.paddingXS + context.borderWidthThin,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with countdown
              _buildHeader(context),

              // Checklist
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: context.paddingXXL),
                  child: Column(
                    children: [
                      _buildTitle(context),
                      SizedBox(height: context.paddingXL),
                      ..._checklist.map((item) => _buildChecklistItem(context, item)),
                      SizedBox(height: context.paddingXL),
                    ],
                  ),
                ),
              ),

              // Action buttons
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.paddingXXL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Get Ready',
            style: context.headingStyle(color: AppColors.greyLight)
          ),
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _countdown <= 5 ? _pulseAnimation.value : 1.0,
                child: CircleAvatar(
                  radius: context.lg,
                  backgroundColor: _countdown <= 5
                      ? Colors.red.withAlpha(51)
                      : Colors.blue.withAlpha(51),
                  child: Center(
                    child: Text(
                      '$_countdown',
                      style: TextStyle(
                        color: _countdown <= 5 ? Colors.red : Colors.white,
                        fontSize: context.fontSizeMd,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.checklist_rtl,
          color: Colors.blue,
          size: context.iconSize ,
        ),
        SizedBox(height: context.sm),
        Text(
          'Please ensure the following before starting your interview:',
          style: context.subheadingStyle(color: AppColors.greyLight),
          textAlign: TextAlign.center,)
      ],
    );
  }

  Widget _buildChecklistItem(BuildContext context, Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: context.md),
      padding: EdgeInsets.all(context.md),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(26), // 0.1 * 255 = 25.5 ≈ 26
        borderRadius: BorderRadius.circular(context.paddingMD),
        border: Border.all(
          color: Colors.white.withAlpha(51), // 0.2 * 255 = 51
          width: context.borderWidthThin,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: context.spaceBtwItemsH + context.paddingXXL,
            height: context.spaceBtwItemsH + context.paddingXXL,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51), // 0.2 * 255 = 51
              borderRadius: BorderRadius.circular(context.sm),
            ),
            child: Icon(
              item['icon'],
              color: AppColors.purpleLight,
              size: context.paddingXL,
            ),
          ),
          SizedBox(width: context.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: context.interviewInformationTitleStyle
                ),
                SizedBox(height: context.xs),
                Text(
                  item['description'],
                  style: context.interviewInformationSubTitleStyle
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle_outline,
            color: Colors.green.withAlpha(179), // 0.7 * 255 = 178.5 ≈ 179
            size: context.paddingXL,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.paddingXXL),
      child: Row(
        children: [
          // Cancel button
          Expanded(
            child: OutlinedButton(
              onPressed: _cancelInterview,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: context.md),
                side: BorderSide(color: Colors.white.withAlpha(77)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.paddingMD),
                ),
              ),
              child: Text(
                AppStrings.cancel,
                style: context.buttonWhiteTextStyle),
            ),
          ),

          SizedBox(width: context.md),

          // Skip timer button
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _skipTimer,

              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
                padding: EdgeInsets.symmetric(vertical: context.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.paddingMD),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.skip_next,
                    color: Colors.white,
                    size: context.paddingXL,
                  ),
                  SizedBox(width: context.sm),
                  Text(
                    'Skip Timer',
                    style: context.buttonWhiteTextStyle
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}