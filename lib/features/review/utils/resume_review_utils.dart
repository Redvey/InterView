import 'package:file_picker/file_picker.dart';

class ResumeReviewUtils {
  /// Opens file picker and returns the selected file name (or null if cancelled)
  static Future<PlatformFile?> pickResumeFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files.first;
    }

    return null;
  }
}
