import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:interview/features/widgets/final_step_dialog.dart';
import '../screens/profile_setup/helpers/file_validators.dart';
import '../screens/profile_setup/widgets/processing_dialog_box.dart';

class ResumeUploadService {
  final BuildContext context;
  final Function(Map<String, dynamic>) onProfileDataUpdate;
  final Function(String) onShowError;

  ResumeUploadService({
    required this.context,
    required this.onProfileDataUpdate,
    required this.onShowError,
  });

  Future<void> uploadResume() async {
    if (!_isMounted) return;
    context.pop(); // Close quick setup dialog

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      allowMultiple: false,
    );

    if (!_isMounted) return;

    if (result != null && result.files.single.path != null) {
      PlatformFile file = result.files.first;
      await _processSelectedFile(file);
    }
  }

  Future<void> _processSelectedFile(PlatformFile file) async {
    // Validate file first
    final validation = FileValidationHelper.validateFile(file);
    if (!validation.isValid) {
      onShowError(validation.errorMessage!);
      return;
    }

    // Analyze if it's likely a resume
    final analysis = FileValidationHelper.analyzeResumeFile(file);

    if (analysis.isLikelyResume) {
      // File looks like a resume, proceed with processing
      await _showProcessingDialogWithProgress(file);
    } else {
      // File might not be a resume, show warning
      await _handleSuspiciousFile(file, analysis);
    }
  }

  Future<void> _handleSuspiciousFile(PlatformFile file, ResumeAnalysisResult analysis) async {
    if (!_isMounted) return;

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return FinalStepDialog(
          title: 'File Type Notice',
          subTitle: _buildFileNoticeMessage(file, analysis),
          yes: 'Continue Anyway',
          no: 'Try Again',
          onNoPressed: () {
            context.pop();
            _showResumeUploadDialog();
          },
          onYesPressed: () {
            context.pop();
            _processFileAfterConfirmation(file);
          },
        );
      },
    );
  }

  String _buildFileNoticeMessage(PlatformFile file, ResumeAnalysisResult analysis) {
    final fileInfo = 'File: "${file.name}"\n'
        'Type: ${FileValidationHelper.getFileTypeDescription(file.extension)}\n'
        'Size: ${FileValidationHelper.getReadableFileSize(file.size)}\n\n';

    final analysisInfo = 'Analysis:\n${analysis.reasons.map((r) => '• $r').join('\n')}\n\n';

    const expectation = 'Resume files typically contain:\n'
        '• Personal contact information\n'
        '• Work experience and employment history\n'
        '• Skills and qualifications\n'
        '• Education details\n\n';

    return '$fileInfo$analysisInfo$expectation${analysis.suggestion}\n\n'
        'Do you want to continue processing this file?';
  }



  Future<void> _processFileAfterConfirmation(PlatformFile file) async {
    if (!_isMounted) return;
    await _showProcessingDialogWithProgress(file);
  }

  Future<void> _showProcessingDialogWithProgress(PlatformFile file) async {
    if (!_isMounted) return;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProcessingDialogWithProgress(
        file: file,
        onProfileDataUpdate: onProfileDataUpdate,
      ),
    );
  }

  Future<void> _showResumeUploadDialog() async {
    if (!_isMounted) return;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return FinalStepDialog(
          title: 'Quick Setup',
          subTitle: 'Would you like to upload your resume to automatically fill in your profile details?',
          yes: 'Upload Resume',
          no: 'Skip for now',
          onYesPressed: uploadResume,
        );
      },
    );
  }

  bool get _isMounted => context.mounted;
}