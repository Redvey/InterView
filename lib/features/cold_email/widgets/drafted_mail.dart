import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../core/constants/image_strings.dart';
import '../../widgets/glass_decoration.dart';
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.radiusLG),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.radiusLG),
          image: DecorationImage(
            image: AssetImage(AppImage.temp1),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(context.paddingMD),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.drafts, color: AppColors.searchFill),
                SizedBox(width: context.mxs),
                Text(
                  AppStrings.draftEmails,
                  style: context.sectionTitleStyle.copyWith(color: AppColors.searchFill),
                ),
              ],
            ),
            SizedBox(height: context.spaceBtwItemsH),
            SizedBox(
              width: double.maxFinite,
              height: context.lottieHeight + context.xl,
              child: drafts.isEmpty
                  ? _buildEmptyState()
                  : _buildDraftsList(),
            ),
            SizedBox(height: context.spaceBtwItemsH),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                ),
                child: Text(
                  AppStrings.close,
                  style: context.navTextStyle(AppColors.searchFill),
                ),
              ),
            ),
          ],
        ),
      ),
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
        return Padding(
          padding: EdgeInsets.symmetric(vertical: context.mxs),
          child: Glass(
            padding: context.paddingXS,
            child: ListTile(
              leading: const Icon(Icons.email, color: AppColors.white),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: AppColors.error),
                onPressed: () => _deleteDraft(draft.id),
              ),
              title: Text(
                draft.subject.isEmpty
                    ? AppStrings.untitledDraft
                    : draft.subject,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.buttonTextStyle.copyWith(color: AppColors.white),
              ),
              subtitle: Text(
                '${AppStrings.to}: ${draft.recipientEmail}\n${widget.coldMailService.formatDate(draft.createdAt)}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: context.hintTextStyle(color: AppColors.searchFill),
              ),
              onTap: () => _selectDraft(draft),
            ),
          ),
        );
      },
    );
  }


  void _deleteDraft(String draftId) {
    widget.coldMailService.deleteDraft(draftId);
    _refreshDrafts();
  }

  void _selectDraft(EmailDraftModel draft) {
    widget.onDraftSelected(draft);
    context.pop();
  }
}
