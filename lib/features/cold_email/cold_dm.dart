import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/resume/screens/widgets/resume_builder_home_widgets/resume_form_top_bar.dart';
import '../../core/constants/colors.dart';
import 'widgets/template_selection_widget.dart';
import 'widgets/recipient_details_widget.dart';
import 'widgets/file_attachment_widget.dart';
import 'widgets/email_composition_widget.dart';
import 'services/cold_mail_service.dart';
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

    _scrollController.addListener(() {
      final max = _scrollController.position.maxScrollExtent;
      final current = _scrollController.offset;
      final isBottom = current >= max * 0.95;
      final isTop = current <= 10;

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
      userName: userName, // Pass the hardcoded user name
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate placeholders
    final unfilled = _coldMailService.validatePlaceholders(
      _bodyController.text,
      _subjectController.text,
    );

    if (unfilled.isNotEmpty && mounted) {
      _showPlaceholderAlert(unfilled);
      return;
    }

    if (_recipientEmailController.text.isEmpty && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter recipient email address')),
      );
      return;
    }

    // Show loading indicator
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              ),
              SizedBox(width: 16),
              Text('Opening email client...'),
            ],
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blue,
        ),
      );
    }

    try {
      await _coldMailService.sendEmail(
        recipientEmail: _recipientEmailController.text,
        subject: _subjectController.text,
        body: _bodyController.text,
        attachments: attachedFiles,
      );

      if (mounted) {
        _clearDraft();
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Email client opened successfully!'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.error, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Failed to open email client', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Error: ${e.toString()}',
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please make sure you have an email app installed (Gmail, Outlook, etc.)',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () => _sendEmail(),
            ),
          ),
        );
      }
    }
  }

  void _showPlaceholderAlert(List<String> unfilled) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.orange),
              SizedBox(width: 8),
              Text('Incomplete Email'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Please fill in the following placeholders:'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: unfilled.map((placeholder) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      '• $placeholder',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  )).toList(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              child: const Text('OK'),
            ),
          ],
        );
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
          content: const Row(
            children: [
              Icon(Icons.save, color: Colors.white),
              SizedBox(width: 8),
              Text('Draft saved locally!'),
            ],
          ),
          backgroundColor: Colors.blue,
          action: SnackBarAction(
            label: 'View Drafts',
            textColor: Colors.white,
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
    final drafts = _coldMailService.getDrafts();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.drafts, color: Colors.blue),
              SizedBox(width: 8),
              Text('Draft Emails'),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: drafts.isEmpty
                ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 48, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No drafts found', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
                : ListView.builder(
              itemCount: drafts.length,
              itemBuilder: (context, index) {
                final draft = drafts[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: const Icon(Icons.email, color: Colors.blue),
                    title: Text(
                      draft.subject.isEmpty ? 'Untitled Draft' : draft.subject,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      'To: ${draft.recipientEmail}\n${_coldMailService.formatDate(draft.createdAt)}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _coldMailService.deleteDraft(draft.id);
                        Navigator.of(dialogContext).pop();
                        _showDraftsDialog(); // Refresh dialog
                      },
                    ),
                    onTap: () {
                      _loadDraftData(draft);
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              child: const Text('Close'),
            ),
          ],
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.restore, color: Colors.white),
              SizedBox(width: 8),
              Text('Draft loaded successfully!'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
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
                    title: "Cold Mail",
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: context.defaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // Template Selection
                        TemplateSelectionWidget(
                          selectedTemplate: selectedTemplate,
                          onTemplateChanged: _handleTemplateChange,
                          onShowDrafts: _showDraftsDialog,
                        ),

                        const SizedBox(height: 16),

                        // Recipient Details
                        RecipientDetailsWidget(
                          recipientController: _recipientController,
                          recipientEmailController: _recipientEmailController,
                          companyController: _companyController,
                          positionController: _positionController,
                          onPersonalize: _personalizeEmail,
                        ),

                        const SizedBox(height: 16),

                        // File Attachments
                        FileAttachmentWidget(
                          attachedFiles: attachedFiles,
                          onFilesChanged: _handleFileSelection,
                        ),

                        const SizedBox(height: 16),

                        // Email Composition
                        EmailCompositionWidget(
                          subjectController: _subjectController,
                          bodyController: _bodyController,
                          onSaveDraft: _saveDraft,
                          onSendEmail: _sendEmail,
                        ),

                        const SizedBox(height: 100), // Space for FAB
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
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
          },
          backgroundColor: AppColors.blackLight,
          child: AnimatedRotation(
            turns: _scrolledToBottom ? 0.5 : 0.0, // 0.5 turns = 180°
            duration: const Duration(milliseconds: 300),
            child: Icon(Icons.arrow_downward, color: AppColors.searchFill),
          ),
        ),
      ),
    );
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