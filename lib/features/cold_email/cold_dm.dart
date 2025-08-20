import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/features/cold_email/services/cold_mail_service.dart';
import 'package:interview/features/cold_email/widgets/drafted_mail.dart';
import 'package:interview/features/cold_email/widgets/email_composition/email_composition_widget.dart';
import 'package:interview/features/cold_email/widgets/file_attachment/file_attachment_widget.dart';
import 'package:interview/features/cold_email/widgets/placeholder_alert_dialog.dart';
import 'package:interview/features/cold_email/widgets/recipient_details/recipient_details_widget.dart';
import 'package:interview/features/cold_email/widgets/template_selection/template_selection_widget.dart';
import 'package:interview/features/resume/screens/widgets/resume_builder_home_widgets/resume_form_top_bar.dart';
import 'models/email_draft_model.dart';


class ColdMail extends StatefulWidget {
  const ColdMail({super.key});

  @override
  State<ColdMail> createState() => _ColdMailState();
}

class _ColdMailState extends State<ColdMail> {
  final ColdMailService _coldMailService = ColdMailService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  bool _scrolledToBottom = false;

  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _recipientEmailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  String selectedTemplate = 'informational';
  List<dynamic> attachedFiles = [];

  // Hardcoded user name for now - TODO: fetch from app user
  static const String userName = 'Roopam';

  @override
  void initState() {
    super.initState();
    _updateEmailTemplate();
    _loadDraft();
    _setupScrollListener();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      final max = _scrollController.position.maxScrollExtent;
      final current = _scrollController.offset;
      final isBottom = current >= max * 0.95;
      final isTop = current <= context.spaceLessH;

      if (isBottom && !_scrolledToBottom) {
        setState(() => _scrolledToBottom = true);
      } else if (isTop && _scrolledToBottom) {
        setState(() => _scrolledToBottom = false);
      }
    });
  }

  void _updateEmailTemplate() {
    final template = _coldMailService.getEmailTemplate(selectedTemplate);
    setState(() {
      _bodyController.text = template;
      _subjectController.text = _coldMailService.getDefaultSubject(selectedTemplate);
    });
  }

  void _personalizeEmail() {
    final personalizedData = _coldMailService.personalizeEmail(
      bodyTemplate: _bodyController.text,
      subjectTemplate: _subjectController.text,
      recipientName: _recipientController.text,
      companyName: _companyController.text,
      position: _positionController.text,
      userName: userName,
    );

    setState(() {
      _bodyController.text = personalizedData['body'] ?? '';
      _subjectController.text = personalizedData['subject'] ?? '';
    });
  }

  void _handleFileSelection(List<dynamic> files) {
    setState(() {
      attachedFiles = files;
    });
  }

  void _handleTemplateChange(String template) {
    setState(() {
      selectedTemplate = template;
    });
    _updateEmailTemplate();
  }

  Future<void> _sendEmail() async {
    // Check recipient email FIRST (before form validation)
    if (_recipientEmailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      if (mounted) {
        _showSnackBar(
          AppStrings.pleaseEnterRecipientEmail,
          AppColors.error,
          Icons.warning,
        );
      }
      return;
    }

    // Validate email format (optional but recommended)
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_recipientEmailController.text.trim())) {
      ScaffoldMessenger.of(context).clearSnackBars();
      if (mounted) {
        _showSnackBar(
          "Please enter a valid email address",
          AppColors.error,
          Icons.warning,
        );
      }
      return;
    }

    // Then check if form validation passes
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate placeholders
    final unfilled = _coldMailService.validatePlaceholders(
      _bodyController.text,
      _subjectController.text,
    );

    if (unfilled.isNotEmpty) {
      if (mounted) {
        _showPlaceholderAlert(unfilled);
      }
      return;
    }

    _showLoadingSnackBar();

    try {
      await _coldMailService.sendEmail(
        recipientEmail: _recipientEmailController.text.trim(),
        subject: _subjectController.text,
        body: _bodyController.text,
        attachments: attachedFiles,
      );

      if (mounted) {
        _clearDraft();
        ScaffoldMessenger.of(context).clearSnackBars();
        _showSnackBar(
          AppStrings.emailClientOpenedSuccess,
          AppColors.success,
          Icons.check_circle,
          duration: 3,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        _showErrorSnackBar(e.toString());
      }
    }
  }

  void _showLoadingSnackBar() {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: context.md,
              height: context.md,
              child: CircularProgressIndicator(
                strokeWidth: context.borderWidthThin,
                color: AppColors.white,
              ),
            ),
            SizedBox(width: context.spaceBtwItems),
            Text(AppStrings.openingEmailClient),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _showErrorSnackBar(String error) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.error, color: AppColors.white),
                SizedBox(width: context.mxs),
                Text(
                  AppStrings.failedToOpenEmailClient,
                  style: context.bodyBoldStyle.copyWith(color: AppColors.white),
                ),
              ],
            ),
            SizedBox(height: context.mxs),
            Text(
              'Error: $error',
              style: context.hintTextStyle(color: AppColors.white)
                  .copyWith(fontSize: context.fontSizeSs),
            ),
            SizedBox(height: context.mxs),
            Text(
              AppStrings.emailAppInstallationHint,
              style: context.hintTextStyle(color: AppColors.white)
                  .copyWith(fontSize: context.fontSizeSs),
            ),
          ],
        ),
        backgroundColor: AppColors.error,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: AppStrings.retry,
          textColor: AppColors.white,
          onPressed: () => _sendEmail(),
        ),
      ),
    );
  }

  void _showSnackBar(String message, Color backgroundColor, IconData icon, {int duration = 2}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: AppColors.white),
            SizedBox(width: context.mxs),
            Text(message),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: duration),
      ),
    );
  }

  void _showPlaceholderAlert(List<String> unfilled) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return PlaceholderAlertDialog(unfilledPlaceholders: unfilled);
      },
    );
  }

  void _saveDraft() {
    final draft = EmailDraftModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      recipientName: _recipientController.text,
      recipientEmail: _recipientEmailController.text,
      company: _companyController.text,
      position: _positionController.text,
      subject: _subjectController.text,
      body: _bodyController.text,
      template: selectedTemplate,
      attachments: attachedFiles.map((f) => f.name as String).toList(),
      createdAt: DateTime.now(),
    );

    _coldMailService.saveDraft(draft);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.save, color: AppColors.white),
              SizedBox(width: context.mxs),
              Text(AppStrings.draftSavedLocally),
            ],
          ),
          backgroundColor: AppColors.primary,
          action: SnackBarAction(
            label: AppStrings.viewDrafts,
            textColor: AppColors.white,
            onPressed: () => _showDraftsDialog(),
          ),
        ),
      );
    }
  }

  void _loadDraft() {
    // Load draft functionality - placeholder
  }

  void _clearDraft() {
    setState(() {
      _recipientController.clear();
      _recipientEmailController.clear();
      _companyController.clear();
      _positionController.clear();
      _subjectController.clear();
      _bodyController.clear();
      attachedFiles.clear();
    });
  }

  void _showDraftsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return DraftsDialog(
          coldMailService: _coldMailService,
          onDraftSelected: _loadDraftData,
        );
      },
    );
  }

  void _loadDraftData(EmailDraftModel draft) {
    setState(() {
      _recipientController.text = draft.recipientName;
      _recipientEmailController.text = draft.recipientEmail;
      _companyController.text = draft.company;
      _positionController.text = draft.position;
      _subjectController.text = draft.subject;
      _bodyController.text = draft.body;
      selectedTemplate = draft.template;
      // Note: attachments would need to be handled separately
    });

    if (mounted) {
      _showSnackBar(
        AppStrings.draftLoadedSuccess,
        AppColors.success,
        Icons.restore,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: context.defaultPadding,
                  child: ResumeFormTopBar(
                    pageColor: AppColors.blackLight,
                    title: AppStrings.coldMail,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: context.defaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: context.mdV),

                        // Template Selection
                        TemplateSelectionWidget(
                          selectedTemplate: selectedTemplate,
                          onTemplateChanged: _handleTemplateChange,
                          onShowDrafts: _showDraftsDialog,
                        ),

                        SizedBox(height: context.spaceBtwItemsH),

                        // Recipient Details
                        RecipientDetailsWidget(
                          recipientController: _recipientController,
                          recipientEmailController: _recipientEmailController,
                          companyController: _companyController,
                          positionController: _positionController,
                          onPersonalize: _personalizeEmail,
                        ),

                        SizedBox(height: context.spaceBtwItemsH),

                        // File Attachments
                        FileAttachmentWidget(
                          attachedFiles: attachedFiles,
                          onFilesChanged: _handleFileSelection,
                        ),

                        SizedBox(height: context.spaceBtwItemsH),

                        // Email Composition
                        EmailCompositionWidget(
                          subjectController: _subjectController,
                          bodyController: _bodyController,
                          onSaveDraft: _saveDraft,
                          onSendEmail: _sendEmail,
                        ),

                        SizedBox(height: context.attachedFileItemHeight),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _handleScrollButtonPress,
          backgroundColor: AppColors.blackLight,
          child: AnimatedRotation(
            turns: _scrolledToBottom ? 0.5 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Icon(Icons.arrow_downward, color: AppColors.searchFill),
          ),
        ),
      ),
    );
  }

  void _handleScrollButtonPress() {
    if (_scrolledToBottom) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    } else {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _recipientEmailController.dispose();
    _companyController.dispose();
    _positionController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}