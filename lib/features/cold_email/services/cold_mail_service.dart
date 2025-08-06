// services/cold_mail_service.dart
import 'package:url_launcher/url_launcher.dart';
import '../models/email_draft_model.dart';

class ColdMailService {
  // In a real app, you'd use SharedPreferences or a database
  static final List<EmailDraftModel> _drafts = [];

  final Map<String, String> _emailTemplates = {
    'informational': '''Dear [Name],

I hope this email finds you well. I'm [Your Name], a [Your Background] interested in learning more about your experience at [Company].

I would greatly appreciate the opportunity to have a brief informational interview with you to gain insights into [Specific Area/Role].

Would you be available for a 15-20 minute conversation in the coming weeks?

Thank you for your time and consideration.

Best regards,
[Your Name]''',

    'job_inquiry': '''Dear [Name],

I hope you're doing well. I'm writing to express my interest in potential opportunities at [Company].

With my background in [Your Field], I believe I could contribute meaningfully to your team. I'm particularly drawn to [Company] because of [Specific Reason].

I would welcome the opportunity to discuss how my skills align with your current or future needs.

Thank you for your consideration.

Best regards,
[Your Name]''',

    'networking': '''Dear [Name],

I hope this message finds you well. I came across your profile and was impressed by your work at [Company].

As someone interested in [Industry/Field], I would value the opportunity to connect and learn from your experience.

Would you be open to a brief coffee chat or virtual meeting in the coming weeks?

Looking forward to potentially connecting.

Best regards,
[Your Name]''',
  };

  String getEmailTemplate(String templateKey) {
    return _emailTemplates[templateKey] ?? '';
  }

  String getDefaultSubject(String templateKey) {
    switch (templateKey) {
      case 'informational':
        return 'Request for Informational Interview - [Your Name]';
      case 'job_inquiry':
        return 'Interest in Opportunities at [Company] - [Your Name]';
      case 'networking':
        return 'Connecting in [Industry/Field] - [Your Name]';
      default:
        return 'Professional Inquiry - [Your Name]';
    }
  }

  Map<String, String> personalizeEmail({
    required String bodyTemplate,
    required String subjectTemplate,
    required String recipientName,
    required String companyName,
    required String position,
  }) {
    String personalizedBody = bodyTemplate;
    String personalizedSubject = subjectTemplate;

    if (recipientName.isNotEmpty) {
      personalizedBody = personalizedBody.replaceAll('[Name]', recipientName);
      personalizedSubject = personalizedSubject.replaceAll('[Name]', recipientName);
    }

    if (companyName.isNotEmpty) {
      personalizedBody = personalizedBody.replaceAll('[Company]', companyName);
      personalizedSubject = personalizedSubject.replaceAll('[Company]', companyName);
    }

    if (position.isNotEmpty) {
      personalizedBody = personalizedBody.replaceAll('[Specific Area/Role]', position);
      personalizedBody = personalizedBody.replaceAll('[Your Field]', position);
      personalizedBody = personalizedBody.replaceAll('[Industry/Field]', position);
      personalizedSubject = personalizedSubject.replaceAll('[Industry/Field]', position);
    }

    return {
      'body': personalizedBody,
      'subject': personalizedSubject,
    };
  }

  List<String> validatePlaceholders(String emailBody, String subject) {
    List<String> unfilled = [];
    RegExp placeholderRegex = RegExp(r'\[([^\]]+)\]');

    // Check body placeholders
    Iterable<RegExpMatch> bodyMatches = placeholderRegex.allMatches(emailBody);
    for (RegExpMatch match in bodyMatches) {
      String placeholder = match.group(0)!;
      if (!unfilled.contains(placeholder)) {
        unfilled.add(placeholder);
      }
    }

    // Check subject placeholders
    Iterable<RegExpMatch> subjectMatches = placeholderRegex.allMatches(subject);
    for (RegExpMatch match in subjectMatches) {
      String placeholder = match.group(0)!;
      if (!unfilled.contains(placeholder)) {
        unfilled.add(placeholder);
      }
    }

    return unfilled;
  }

  Future<void> sendEmail({
    required String recipientEmail,
    required String subject,
    required String body,
    required List<dynamic> attachments,
  }) async {
    String emailUrl = _buildEmailUrl(
      recipientEmail: recipientEmail,
      subject: subject,
      body: body,
      attachments: attachments,
    );

    Uri uri = Uri.parse(emailUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch email client';
    }
  }

  String _buildEmailUrl({
    required String recipientEmail,
    required String subject,
    required String body,
    required List<dynamic> attachments,
  }) {
    String to = Uri.encodeComponent(recipientEmail);
    String encodedSubject = Uri.encodeComponent(subject);
    String bodyWithAttachments = body;

    // Add attachment note to body if files are attached
    if (attachments.isNotEmpty) {
      String attachmentNote = '\n\nNote: Please attach the following files:\n';
      for (var file in attachments) {
        attachmentNote += '• ${file.name}\n';
      }
      bodyWithAttachments += attachmentNote;
    }

    String encodedBody = Uri.encodeComponent(bodyWithAttachments);
    return 'mailto:$to?subject=$encodedSubject&body=$encodedBody';
  }

  void saveDraft(EmailDraftModel draft) {
    // Remove existing draft with same ID
    _drafts.removeWhere((d) => d.id == draft.id);
    _drafts.add(draft);
    // In a real app, persist to SharedPreferences or database
  }

  List<EmailDraftModel> getDrafts() {
    return List.from(_drafts);
  }

  void deleteDraft(String draftId) {
    _drafts.removeWhere((draft) => draft.id == draftId);
    // In a real app, remove from SharedPreferences or database
  }

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
}