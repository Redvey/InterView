import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:interview/app/themes/fonts.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/cold_email/widgets/file_attachment/services/file_picker_service.dart';
import 'package:interview/features/cold_email/widgets/file_attachment/widgets/attached_file_item.dart';
import 'package:interview/features/cold_email/widgets/file_attachment/widgets/attachment_header.dart';
import 'package:interview/features/cold_email/widgets/file_attachment/widgets/no_files_placeholder.dart';


class FileAttachmentWidget extends StatelessWidget {
  final List<dynamic> attachedFiles;
  final Function(List<dynamic>) onFilesChanged;

  const FileAttachmentWidget({
    super.key,
    required this.attachedFiles,
    required this.onFilesChanged,
  });

  Future<void> _pickFiles(BuildContext context) async {
    final List<PlatformFile>? newFiles = await FilePickerService.pickFiles(context);
    if (newFiles != null) {
      final updatedFiles = List<dynamic>.from(attachedFiles)..addAll(newFiles);
      onFilesChanged(updatedFiles);
    }
  }

  void _removeFile(int index) {
    final updatedFiles = List<dynamic>.from(attachedFiles)..removeAt(index);
    onFilesChanged(updatedFiles);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.defaultPadding,
      decoration: BoxDecoration(
        color: AppColors.socialForm,
        borderRadius: BorderRadius.circular(context.borderRadiusLx),
        border: Border.all(color: AppColors.backgroundBlue.withAlpha(77)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AttachmentHeader(onAddFiles: () => _pickFiles(context)),
          if (attachedFiles.isNotEmpty) ...[
             SizedBox(height: context.defaultSpaceH),
            Text(
              '${attachedFiles.length} file${attachedFiles.length == 1 ? '' : 's'} selected',
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                color: AppColors.blackLight.withAlpha(153),
                fontSize: 12,
              ),
            ),
            SizedBox(height: context.defaultSpaceH),
            SizedBox(
              height: context.attachedFileItemHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: attachedFiles.length,
                itemBuilder: (context, index) {
                  final file = attachedFiles[index] as PlatformFile;
                  return AttachedFileItem(
                    file: file,
                    onRemove: () => _removeFile(index),
                  );
                },
              ),
            ),
          ] else
            const NoFilesPlaceholder(),
        ],
      ),
    );
  }
}