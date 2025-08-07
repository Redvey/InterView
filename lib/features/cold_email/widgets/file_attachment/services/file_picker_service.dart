import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerService {
  /// Opens the platform's file picker and returns a list of selected files.
  /// Returns null if the user cancels the picker.
  static Future<List<PlatformFile>?> pickFiles(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        return result.files;
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking files: $e')),
        );
      }
    }
    return null;
  }
}