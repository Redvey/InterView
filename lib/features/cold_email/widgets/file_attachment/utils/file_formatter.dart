import 'package:flutter/material.dart';

/// Returns a file-type-specific IconData.
IconData getFileIcon(String fileName) {
  final extension = fileName.split('.').last.toLowerCase();
  switch (extension) {
    case 'pdf':
      return Icons.picture_as_pdf_outlined;
    case 'doc':
    case 'docx':
      return Icons.article_outlined;
    case 'xls':
    case 'xlsx':
      return Icons.analytics_outlined;
    case 'ppt':
    case 'pptx':
      return Icons.slideshow_outlined;
    case 'jpg':
    case 'jpeg':
    case 'png':
    case 'gif':
      return Icons.image_outlined;
    case 'zip':
    case 'rar':
      return Icons.folder_zip_outlined;
    case 'txt':
      return Icons.text_snippet_outlined;
    default:
      return Icons.attach_file;
  }
}

/// Formats file size in bytes to a human-readable string (KB, MB).
String formatFileSize(int? bytes) {
  if (bytes == null) return '';
  if (bytes < 1024) return '${bytes}B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
}