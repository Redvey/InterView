// models/email_draft_model.dart
class EmailDraftModel {
  final String id;
  final String recipientName;
  final String recipientEmail;
  final String company;
  final String position;
  final String subject;
  final String body;
  final String template;
  final List<String> attachments;
  final DateTime createdAt;

  EmailDraftModel({
    required this.id,
    required this.recipientName,
    required this.recipientEmail,
    required this.company,
    required this.position,
    required this.subject,
    required this.body,
    required this.template,
    required this.attachments,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipientName': recipientName,
      'recipientEmail': recipientEmail,
      'company': company,
      'position': position,
      'subject': subject,
      'body': body,
      'template': template,
      'attachments': attachments,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory EmailDraftModel.fromJson(Map<String, dynamic> json) {
    return EmailDraftModel(
      id: json['id'],
      recipientName: json['recipientName'] ?? '',
      recipientEmail: json['recipientEmail'] ?? '',
      company: json['company'] ?? '',
      position: json['position'] ?? '',
      subject: json['subject'] ?? '',
      body: json['body'] ?? '',
      template: json['template'] ?? 'informational',
      attachments: List<String>.from(json['attachments'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  EmailDraftModel copyWith({
    String? id,
    String? recipientName,
    String? recipientEmail,
    String? company,
    String? position,
    String? subject,
    String? body,
    String? template,
    List<String>? attachments,
    DateTime? createdAt,
  }) {
    return EmailDraftModel(
      id: id ?? this.id,
      recipientName: recipientName ?? this.recipientName,
      recipientEmail: recipientEmail ?? this.recipientEmail,
      company: company ?? this.company,
      position: position ?? this.position,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      template: template ?? this.template,
      attachments: attachments ?? this.attachments,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}