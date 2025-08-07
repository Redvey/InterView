import 'package:flutter/material.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/widgets/upload_download_button.dart';

class AttachmentHeader extends StatelessWidget {
  final VoidCallback onAddFiles;

  const AttachmentHeader({super.key, required this.onAddFiles});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(AppStrings.attachments, style: context.infoSmallHeaderStyle),
        const Spacer(),
        UploadDownloadButton(
          fileName: AppStrings.addFiles,
          onPick: onAddFiles,
          icon: Icons.attach_file,
          process: "",
          buttonPaddingH: context.buttonHeightSmall,
        ),
      ],
    );
  }
}
