class ResumeData {
  final String id;
  final String name;
  final String fileName;
  final DateTime createdAt;
  final String? filePath;
  final int templateIndex;

  ResumeData({
    required this.id,
    required this.name,
    required this.fileName,
    required this.createdAt,
    this.filePath,
    required this.templateIndex,
  });

  factory ResumeData.fromJson(Map<String, dynamic> json) {
    return ResumeData(
      id: json['id'],
      name: json['name'],
      fileName: json['fileName'],
      createdAt: DateTime.parse(json['createdAt']),
      filePath: json['filePath'],
      templateIndex: json['templateIndex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'fileName': fileName,
      'createdAt': createdAt.toIso8601String(),
      'filePath': filePath,
      'templateIndex': templateIndex,
    };
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    }
  }
}