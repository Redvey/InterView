import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import '../models/email_draft_model.dart';
import '../services/cold_mail_service.dart';

class DraftsDialog extends StatefulWidget {
  final ColdMailService coldMailService;
  final Function(EmailDraftModel) onDraftSelected;

  const DraftsDialog({
    super.key,
    required this.coldMailService,
    required this.onDraftSelected,
  });

  @override
  State<DraftsDialog> createState() => _DraftsDialogState();
}

class _DraftsDialogState extends State<DraftsDialog> {
  late List<EmailDraftModel> drafts;

  @override
  void initState() {
    super.initState();
    drafts = widget.coldMailService.getDrafts();
  }

  void _refreshDrafts() {
    setState(() {
      drafts = widget.coldMailService.getDrafts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(context.radiusLG),
      ),
      title: Row(
        children: [
          const Icon(Icons.drafts, color: AppColors.primary),
          SizedBox(width: context.mxs),
          Text(
            AppStrings.draftEmails,
            style: context.sectionTitleStyle,
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: context.lottieHeight + context.xl,
        child: drafts.isEmpty
            ? _buildEmptyState()
            : _buildDraftsList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
          ),
          child: Text(
            AppStrings.close,
            style: context.buttonTextStyle.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: context.xl,
            color: AppColors.textGrey,
          ),
          SizedBox(height: context.spaceBtwItemsH),
          Text(
            AppStrings.noDraftsFound,
            style: context.hintTextStyle(color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildDraftsList() {
    return ListView.builder(
      itemCount: drafts.length,
      itemBuilder: (context, index) {
        final draft = drafts[index];
        return Card(
          elevation: context.borderWidthThin,
          margin: EdgeInsets.symmetric(vertical: context.paddingXS),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radiusMD),
          ),
          child: ListTile(
            leading: const Icon(Icons.email, color: AppColors.primary),
            title: Text(
              draft.subject.isEmpty ? AppStrings.untitledDraft : draft.subject,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.bodyBoldStyle,
            ),
            subtitle: Text(
              '${AppStrings.to}: ${draft.recipientEmail}\n${widget.coldMailService.formatDate(draft.createdAt)}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.hintTextStyle(color: AppColors.textGrey),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: AppColors.error),
              onPressed: () => _deleteDraft(draft.id),
            ),
            onTap: () => _selectDraft(draft),
          ),
        );
      },
    );
  }

  void _deleteDraft(String draftId) {
    widget.coldMailService.deleteDraft(draftId);

    // Update the local drafts list immediately
    _refreshDrafts();

  }

  void _selectDraft(EmailDraftModel draft) {
    widget.onDraftSelected(draft);
    Navigator.of(context).pop();
  }
}