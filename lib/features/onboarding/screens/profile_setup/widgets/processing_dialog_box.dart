import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/resume/widgets/final_step_dialog.dart';
import '../../../../../core/constants/colors.dart';
import '../../../services/resume_processing_service.dart';
import '../models/profile_data.dart';

class ProcessingDialogWithProgress extends StatefulWidget {
  final PlatformFile file;
  final Function(Map<String, dynamic>) onProfileDataUpdate;

  const ProcessingDialogWithProgress({
    super.key,
    required this.file,
    required this.onProfileDataUpdate,
  });

  @override
  State<ProcessingDialogWithProgress> createState() => _ProcessingDialogWithProgressState();
}

class _ProcessingDialogWithProgressState extends State<ProcessingDialogWithProgress>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  bool _isProcessing = true;
  bool _isCompleted = false;
  bool _hasError = false;
  String _errorMessage = '';
  ResumeExtractionResult? _extractionResult;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _startProcessing();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  Future<void> _startProcessing() async {
    try {
      // Start the progress animation
      _progressController.forward();

      // Process the resume file - now correctly expecting ResumeExtractionResult
      _extractionResult = await ResumeProcessingService.processResumeFile(widget.file);

      // Wait for animation to complete if it hasn't already
      await _progressController.forward();

      if (mounted) {
        // Check if extraction was successful by checking if profileData exists
        if (_extractionResult!.profileData != null) {
          setState(() {
            _isProcessing = false;
            _isCompleted = true;
          });
        } else {
          setState(() {
            _isProcessing = false;
            _hasError = true;
            _errorMessage = _extractionResult!.errorMessage ?? 'Unknown error occurred';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
          _hasError = true;
          _errorMessage = e.toString();
        });
      }
    }
  }

  void _onDonePressed() {
    if (_extractionResult != null && _extractionResult!.profileData != null) {
      // Convert ProfileData to Map<String, dynamic> for the callback
      final profileDataMap = _extractionResult!.profileData!.toMap();
      widget.onProfileDataUpdate(profileDataMap);
    }
    Navigator.of(context).pop();
  }

  void _onRetryPressed() {
    setState(() {
      _isProcessing = true;
      _hasError = false;
      _errorMessage = '';
      _progressController.reset();
    });
    _startProcessing();
  }

  void _onCancelPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: FinalStepDialog(
        title: '',
        subTitle: '',
        yes: '',
        no: '',
        newChild: true,
        child: Padding(
          padding:  EdgeInsets.all(context.mxs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              SizedBox(height: context.spaceBtwSections),
              if (_isProcessing) _buildProgressSection(),
              if (_isCompleted || _hasError) _buildResultSection(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(

      children: [
        Container(
          padding: EdgeInsets.all(context.sm),
          decoration: BoxDecoration(
            color: _getHeaderColor().withAlpha(26),
            borderRadius: BorderRadius.circular(context.radiusMD),
          ),
          child: Icon(
            _getHeaderIcon(),
            color: _getHeaderColor(),
            size: context.iconSize,
          ),
        ),
        SizedBox(width: context.spaceBtwItems),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getHeaderTitle(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  color: _hasError ? AppColors.error : AppColors.white,
                ) ?? TextStyle(
                  fontSize: 18,
                  color: _hasError ? AppColors.error : AppColors.white,
                ),
              ),
              SizedBox(height: context.xs),
              Text(
                _getHeaderSubtitle(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.grey500,
                  fontSize: 14,
                ) ?? TextStyle(
                  color: AppColors.grey500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return Column(
              children: [
                LinearProgressIndicator(
                  value: _progressAnimation.value,
                  backgroundColor: AppColors.grey300,
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  minHeight: 6,
                ),
                SizedBox(height: context.sm),
                Text(
                  '${(_progressAnimation.value * 100).toInt()}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.grey500,
                    fontSize: 12,
                  ) ?? TextStyle(
                    color: AppColors.grey500,
                    fontSize: 12,
                  ),
                ),
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text('Skip Resume Upload', style: context.buttonWhiteTextStyle),
                ),
              ],
            );
          },
        ),
        SizedBox(height: context.spaceBtwItems),
      ],
    );
  }

  Widget _buildResultSection() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(context.md),
          decoration: BoxDecoration(
            color: _getResultBackgroundColor(),
            borderRadius: BorderRadius.circular(context.radiusMD),
            border: Border.all(
              color: _getResultBorderColor(),
            ),
          ),
          child: Row(
            children: [
              Icon(
                _hasError ? Icons.warning_amber : Icons.info_outline,
                color: _hasError ? AppColors.error : AppColors.success,
                size: context.iconSizeMD,
              ),
              SizedBox(width: context.sm),
              Expanded(
                child: Text(
                  _getResultMessage(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    color: _hasError ? AppColors.error : AppColors.success,
                  ) ?? TextStyle(
                    fontSize: 12,
                    color: _hasError ? AppColors.error : AppColors.success,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.spaceBtwItems),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        if (_hasError) ..._buildErrorButtons(),
        if (_isCompleted) ..._buildSuccessButtons(),
      ],
    );
  }

  List<Widget> _buildErrorButtons() {
    return [
      Expanded(
        child: OutlinedButton(
          onPressed: _onCancelPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.grey400),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.radiusMD),
            ),
          ),
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.grey500,
            ) ?? TextStyle(
              color: AppColors.grey500,
            ),
          ),
        ),
      ),
      SizedBox(width: context.spaceBtwItems),
      Expanded(
        child: ElevatedButton(
          onPressed: _onRetryPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.radiusMD),
            ),
          ),
          child: Text(
            'Try Again',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.white,
            ) ?? TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildSuccessButtons() {
    return [
      Expanded(
        child: ElevatedButton(
          onPressed: _onDonePressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.success,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.radiusMD),
            ),
          ),
          child: Text(
            'Done',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.white,
            ) ?? TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ];
  }

  // Helper methods for dynamic content
  Color _getHeaderColor() {
    if (_hasError) return AppColors.error;
    if (_isCompleted) return AppColors.success;
    return AppColors.primary;
  }

  IconData _getHeaderIcon() {
    if (_hasError) return Icons.error_outline;
    if (_isCompleted) return Icons.check_circle_outline;
    return Icons.description;
  }

  String _getHeaderTitle() {
    if (_hasError) return 'Processing Failed';
    if (_isCompleted) return 'Processing Complete!';
    return 'Processing Resume';
  }

  String _getHeaderSubtitle() {
    if (_hasError) return _errorMessage;
    if (_isCompleted) return 'Your profile has been pre-filled with extracted data';
    return 'Extracting information from your resume...';
  }

  Color _getResultBackgroundColor() {
    return _hasError
        ? AppColors.error.withAlpha(26)
        : AppColors.success.withAlpha(26);
  }

  Color _getResultBorderColor() {
    return _hasError
        ? AppColors.error.withAlpha(67)
        : AppColors.success.withAlpha(67);
  }

  String _getResultMessage() {
    return _hasError
        ? 'Please try again or continue without uploading'
        : 'Resume data has been extracted and applied to your profile';
  }
}