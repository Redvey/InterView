import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import '../models/email_draft_model.dart';

class ColdMailService {
  // Your existing methods for templates, personalization, etc.

  String getEmailTemplate(String templateType) {
    switch (templateType) {
      case 'informational':
        return '''Dear [RECIPIENT_NAME],

I hope this email finds you well. I am reaching out to learn more about [COMPANY] and the opportunities available in [POSITION].

I am particularly interested in [SPECIFIC_INTEREST] and would appreciate any insights you might share about the company culture and growth opportunities.

Would you be available for a brief 15-minute call to discuss your experience at [COMPANY]?

Thank you for your time and consideration.

Best regards,
[YOUR_NAME]''';

      case 'job_application':
        return '''Dear Hiring Manager,

I am writing to express my interest in the [POSITION] position at [COMPANY]. With my background in [YOUR_FIELD], I believe I would be a valuable addition to your team.

[BRIEF_QUALIFICATIONS]

I have attached my resume for your review. I would welcome the opportunity to discuss how my skills and experience align with [COMPANY]'s goals.

Thank you for considering my application.

Best regards,
[YOUR_NAME]''';

      default:
        return '''Dear [RECIPIENT_NAME],

I hope this email finds you well.

[YOUR_MESSAGE]

Thank you for your time.

Best regards,
[YOUR_NAME]''';
    }
  }

  String getDefaultSubject(String templateType) {
    switch (templateType) {
      case 'informational':
        return 'Seeking insights about opportunities at [COMPANY]';
      case 'job_application':
        return 'Application for [POSITION] position';
      default:
        return 'Hello from [YOUR_NAME]';
    }
  }

  Map<String, String> personalizeEmail({
    required String bodyTemplate,
    required String subjectTemplate,
    required String recipientName,
    required String companyName,
    required String position,
    required String userName,
  }) {
    String personalizedBody = bodyTemplate
        .replaceAll('[RECIPIENT_NAME]', recipientName)
        .replaceAll('[COMPANY]', companyName)
        .replaceAll('[POSITION]', position)
        .replaceAll('[YOUR_NAME]', userName);

    String personalizedSubject = subjectTemplate
        .replaceAll('[RECIPIENT_NAME]', recipientName)
        .replaceAll('[COMPANY]', companyName)
        .replaceAll('[POSITION]', position)
        .replaceAll('[YOUR_NAME]', userName);

    return {
      'body': personalizedBody,
      'subject': personalizedSubject,
    };
  }

  List<String> validatePlaceholders(String body, String subject) {
    final List<String> unfilled = [];
    final RegExp placeholderRegex = RegExp(r'\[([^\]]+)\]');

    final bodyMatches = placeholderRegex.allMatches(body);
    final subjectMatches = placeholderRegex.allMatches(subject);

    for (final match in bodyMatches) {
      unfilled.add(match.group(1)!);
    }

    for (final match in subjectMatches) {
      final placeholder = match.group(1)!;
      if (!unfilled.contains(placeholder)) {
        unfilled.add(placeholder);
      }
    }

    return unfilled;
  }

  // Fixed sendEmail method that handles + encoding issue
  Future<void> sendEmail({
    required String recipientEmail,
    required String subject,
    required String body,
    List<dynamic>? attachments,
  }) async {
    if (kDebugMode) {
      print('Attempting to send email to: $recipientEmail');
      print('Subject: $subject');
    }

    try {

      final String encodedSubject = Uri.encodeComponent(subject);
      final String encodedBody = Uri.encodeComponent(body);

      // Manual URL construction to avoid Uri constructor issues
      final String mailtoUrl = 'mailto:$recipientEmail?subject=$encodedSubject&body=$encodedBody';
      final Uri mailtoUri = Uri.parse(mailtoUrl);

      if (kDebugMode) {
        print('Encoded subject: $encodedSubject');
        print('Encoded body preview: ${encodedBody.substring(0, encodedBody.length > 100 ? 100 : encodedBody.length)}...');
        print('Final mailto URL: $mailtoUrl');
      }

      if (await canLaunchUrl(mailtoUri)) {
        final bool launched = await launchUrl(
          mailtoUri,
          mode: LaunchMode.externalApplication,
        );

        if (launched) {
          if (kDebugMode) print('Email client opened successfully');
          return;
        } else {
          throw Exception('Failed to launch email client');
        }
      } else {
        throw Exception('Cannot launch email client - no email app available');
      }
    } catch (e) {
      if (kDebugMode) print('Email launch failed: $e');
      throw Exception('No email client available on this device. Please install an email app like Gmail or Outlook.');
    }
  }

  // Draft management methods
  void saveDraft(EmailDraftModel draft) {
    // Implement your draft saving logic here
    // This could be SharedPreferences, local database, etc.
  }

  List<EmailDraftModel> getDrafts() {
    // Implement your draft retrieval logic here
    return [];
  }

  void deleteDraft(String id) {
    // Implement your draft deletion logic here
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}