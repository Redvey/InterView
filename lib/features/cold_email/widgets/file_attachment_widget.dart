// widgets/file_attachment_widget.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:interview/app/themes/fonts.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../core/constants/colors.dart';

class FileAttachmentWidget extends StatelessWidget {
  final List<dynamic> attachedFiles;
  final Function(List<dynamic>) onFilesChanged;

  const FileAttachmentWidget({
    super.key,
    required this.attachedFiles,
    required this.onFilesChanged,
  });

  Future<void> _pickFiles(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        final updatedFiles = List<dynamic>.from(attachedFiles);
        updatedFiles.addAll(result.files);
        onFilesChanged(updatedFiles);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking files: $e')),
        );
      }
    }
  }

  void _removeFile(int index) {
    final updatedFiles = List<dynamic>.from(attachedFiles);
    updatedFiles.removeAt(index);
    onFilesChanged(updatedFiles);
  }

  String _getFileIcon(String fileName) {
    String extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return '📄';
      case 'doc':
      case 'docx':
        return '📝';
      case 'xls':
      case 'xlsx':
        return '📊';
      case 'ppt':
      case 'pptx':
        return '📋';
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return '🖼️';
      case 'zip':
      case 'rar':
        return '🗜️';
      case 'txt':
        return '📃';
      default:
        return '📎';
    }
  }

  String _formatFileSize(int? bytes) {
    if (bytes == null) return '';
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.searchBorder,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blackLight.withAlpha(77)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Attachments",
                style: context.infoSmallHeaderStyle
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () => _pickFiles(context),
                icon: const Icon(Icons.attach_file, size: 16),
                label:  Text("Add Files",style: context.buttonWhiteTextStyle,),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blackLight.withAlpha(204),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          if (attachedFiles.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              '${attachedFiles.length} file${attachedFiles.length == 1 ? '' : 's'} selected',
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                color: AppColors.blackLight.withAlpha(153), // 0.6 * 255
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: attachedFiles.length,
                itemBuilder: (context, index) {
                  final file = attachedFiles[index];
                  return Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.searchBorder,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.blackLight.withAlpha(51), // 0.2 * 255
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // File header with icon and remove button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _getFileIcon(file.name),
                              style: const TextStyle(fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: () => _removeFile(index),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // File name
                        Expanded(
                          child: Text(
                            file.name,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        // File size
                        if (file.size != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            _formatFileSize(file.size),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ] else ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.searchFill, // 0.2 * 255
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.withAlpha(77), // 0.3 * 255
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 32,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No files attached',
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap "Add Files" to attach documents',
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}