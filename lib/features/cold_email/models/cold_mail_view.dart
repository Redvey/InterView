import 'package:flutter/material.dart';
import 'package:interview/features/cold_email/models/email_draft_model.dart';
import 'package:interview/features/cold_email/services/cold_mail_service.dart';

import '../widgets/drafted_mail.dart';
import '../widgets/placeholder_alert_dialog.dart';

class ColdMailViewModel extends ChangeNotifier {
  final ColdMailService _coldMailService = ColdMailService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  // Controllers
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController recipientEmailController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  // State variables
  String _selectedTemplate = 'informational';
  List<dynamic> _attachedFiles = [];
  bool _scrolledToBottom = false;

  // Hardcoded user name - TODO: fetch from app user
  static const String _userName = 'Roopam';

  // Getters
  String get selectedTemplate => _selectedTemplate;
  List<dynamic> get attachedFiles => _attachedFiles;
  bool get scrolledToBottom => _scrolledToBottom;
  List<EmailDraftModel> get drafts => _coldMailService.getDrafts();

  ColdMailViewModel() {
    _initialize();
  }

  void _initialize() {
    updateEmailTemplate();
    _loadDraft(); // Placeholder for initial draft loading

    scrollController.addListener(() {
      final max = scrollController.position.maxScrollExtent;
      final current = scrollController.offset;
      final isBottom = current >= max * 0.95;

      if (isBottom != _scrolledToBottom) {
        _scrolledToBottom = isBottom;
        notifyListeners();
      }
    });
  }

  void updateEmailTemplate() {
    final template = _coldMailService.getEmailTemplate(_selectedTemplate);
    bodyController.text = template;
    subjectController.text = _coldMailService.getDefaultSubject(_selectedTemplate);
    notifyListeners();
  }

  void personalizeEmail() {
    final personalizedData = _coldMailService.personalizeEmail(
      bodyTemplate: bodyController.text,
      subjectTemplate: subjectController.text,
      recipientName: recipientController.text,
      companyName: companyController.text,
      position: positionController.text,
      userName: _userName,
    );
    bodyController.text = personalizedData['body'] ?? '';
    subjectController.text = personalizedData['subject'] ?? '';
    notifyListeners();
  }

  void handleTemplateChange(String template) {
    _selectedTemplate = template;
    updateEmailTemplate();
  }

  void handleFileSelection(List<dynamic> files) {
    _attachedFiles = files;
    notifyListeners();
  }

  void saveDraft(BuildContext context) {
    final draft = EmailDraftModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      recipientName: recipientController.text,
      recipientEmail: recipientEmailController.text,
      company: companyController.text,
      position: positionController.text,
      subject: subjectController.text,
      body: bodyController.text,
      template: _selectedTemplate,
      attachments: _attachedFiles.map((f) => f.name as String).toList(),
      createdAt: DateTime.now(),
    );
    _coldMailService.saveDraft(draft);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(children: [
          Icon(Icons.save, color: Colors.white),
          SizedBox(width: 8),
          Text('Draft saved locally!')
        ]),
        backgroundColor: Colors.blue,
        action: SnackBarAction(
          label: 'View Drafts',
          textColor: Colors.white,
          onPressed: () => showDraftsDialog(context),
        ),
      ),
    );
  }

  void loadDraftData(BuildContext context, EmailDraftModel draft) {
    recipientController.text = draft.recipientName;
    recipientEmailController.text = draft.recipientEmail;
    companyController.text = draft.company;
    positionController.text = draft.position;
    subjectController.text = draft.subject;
    bodyController.text = draft.body;
    _selectedTemplate = draft.template;
    // Note: attachments would need to be handled separately
    notifyListeners();
    Navigator.of(context).pop(); // Close the drafts dialog

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(children: [
          Icon(Icons.restore, color: Colors.white),
          SizedBox(width: 8),
          Text('Draft loaded successfully!')
        ]),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void deleteDraft(String draftId) {
    _coldMailService.deleteDraft(draftId);
    notifyListeners();
  }

  Future<void> sendEmail(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    final unfilled = _coldMailService.validatePlaceholders(bodyController.text, subjectController.text);
    if (unfilled.isNotEmpty) {
      showDialog(
        context: context,
        builder: (_) => PlaceholderAlertDialog(unfilledPlaceholders: unfilled),
      );
      return;
    }

    if (recipientEmailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter recipient email address')),
      );
      return;
    }

    // Show loading indicator
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Row(children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          ),
          SizedBox(width: 16),
          Text('Opening email client...')
        ]),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ),
    );

    try {
      await _coldMailService.sendEmail(
        recipientEmail: recipientEmailController.text,
        subject: subjectController.text,
        body: bodyController.text,
        attachments: _attachedFiles,
      );
      _clearForm();

      // Check if context is still valid after async operation
      if (context.mounted) {
        scaffoldMessenger.clearSnackBars();
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('Email client opened successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Check if context is still valid after async operation
      if (context.mounted) {
        scaffoldMessenger.clearSnackBars();
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Failed to open email client: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void showDraftsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => DraftsDialog(
        coldMailService: _coldMailService,
        onDraftSelected: (EmailDraftModel draft) {
          loadDraftData(context, draft);
        },
      ),
    );
  }

  void _clearForm() {
    recipientController.clear();
    recipientEmailController.clear();
    companyController.clear();
    positionController.clear();
    subjectController.clear();
    bodyController.clear();
    _attachedFiles.clear();
    updateEmailTemplate(); // Reset to default template
  }

  void _loadDraft() {
    /* Load last saved draft logic here if needed */
  }

  void toggleScroll() {
    final target = _scrolledToBottom ? 0.0 : scrollController.position.maxScrollExtent;
    scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    recipientController.dispose();
    recipientEmailController.dispose();
    companyController.dispose();
    positionController.dispose();
    subjectController.dispose();
    bodyController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}