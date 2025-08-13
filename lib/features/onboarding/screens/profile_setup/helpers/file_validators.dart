import 'package:file_picker/file_picker.dart';

class FileValidationHelper {
  static const List<String> _allowedExtensions = ['pdf', 'doc', 'docx'];
  static const int _maxSizeInBytes = 10 * 1024 * 1024; // 10MB
  static const List<String> _resumeKeywords = ['resume', 'cv', 'curriculum'];

  /// Validates file type and size
  static FileValidationResult validateFile(PlatformFile file) {
    final fileExtension = file.extension?.toLowerCase();

    if (!_allowedExtensions.contains(fileExtension)) {
      return FileValidationResult(
        isValid: false,
        errorMessage: 'Please upload a valid file type (PDF, DOC, DOCX)',
        errorType: FileValidationErrorType.invalidFormat,
      );
    }

    if (file.size > _maxSizeInBytes) {
      return FileValidationResult(
        isValid: false,
        errorMessage: 'File size must be under 10MB',
        errorType: FileValidationErrorType.fileTooLarge,
      );
    }

    return FileValidationResult(isValid: true);
  }

  /// Checks if filename suggests it's a resume
  static bool hasResumeKeywords(String filename) {
    final fileName = filename.toLowerCase();
    return _resumeKeywords.any((keyword) => fileName.contains(keyword));
  }

  /// Gets file size in readable format
  static String getReadableFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// Gets file type description
  static String getFileTypeDescription(String? extension) {
    switch (extension?.toLowerCase()) {
      case 'pdf':
        return 'PDF Document';
      case 'doc':
        return 'Word Document';
      case 'docx':
        return 'Word Document';
      default:
        return 'Unknown File Type';
    }
  }

  /// Checks if file is likely a resume based on various criteria
  static ResumeAnalysisResult analyzeResumeFile(PlatformFile file) {
    final hasKeywords = hasResumeKeywords(file.name);
    final validation = validateFile(file);

    if (!validation.isValid) {
      return ResumeAnalysisResult(
        isLikelyResume: false,
        confidence: 0.0,
        reasons: [validation.errorMessage!],
        suggestion: 'Please select a valid PDF, DOC, or DOCX file under 10MB',
      );
    }

    double confidence = 0.5; // Base confidence
    List<String> reasons = [];

    if (hasKeywords) {
      confidence += 0.4;
      reasons.add('Filename contains resume-related keywords');
    } else {
      confidence -= 0.2;
      reasons.add('Filename doesn\'t contain typical resume keywords');
    }

    // Check file size (typical resume size)
    if (file.size > 50 * 1024 && file.size < 2 * 1024 * 1024) {
      confidence += 0.1;
      reasons.add('File size is typical for resume documents');
    }

    final isLikely = confidence > 0.6;

    return ResumeAnalysisResult(
      isLikelyResume: isLikely,
      confidence: confidence.clamp(0.0, 1.0),
      reasons: reasons,
      suggestion: isLikely
          ? 'This appears to be a resume file'
          : 'This may not be a resume. Resume files typically contain personal info, work experience, and skills',
    );
  }
}

class FileValidationResult {
  final bool isValid;
  final String? errorMessage;
  final FileValidationErrorType? errorType;

  const FileValidationResult({
    required this.isValid,
    this.errorMessage,
    this.errorType,
  });
}

enum FileValidationErrorType {
  invalidFormat,
  fileTooLarge,
  fileEmpty,
}

class ResumeAnalysisResult {
  final bool isLikelyResume;
  final double confidence;
  final List<String> reasons;
  final String suggestion;

  const ResumeAnalysisResult({
    required this.isLikelyResume,
    required this.confidence,
    required this.reasons,
    required this.suggestion,
  });
}