class InterviewItem {
  final String id;
  final String jobTitle;
  final String company;
  final String jobDescription;
  final String difficulty;
  final String duration;
  final List<String> topics;
  final bool isCustom;
  final DateTime? createdAt;

  InterviewItem({
    required this.id,
    required this.jobTitle,
    required this.company,
    required this.jobDescription,
    required this.difficulty,
    required this.duration,
    required this.topics,
    this.isCustom = false,
    this.createdAt,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobTitle': jobTitle,
      'company': company,
      'jobDescription': jobDescription,
      'difficulty': difficulty,
      'duration': duration,
      'topics': topics,
      'isCustom': isCustom,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  // Create from JSON
  factory InterviewItem.fromJson(Map<String, dynamic> json) {
    try {
      return InterviewItem(
        id: json['id'] as String,
        jobTitle: json['jobTitle'] as String,
        company: json['company'] as String,
        jobDescription: json['jobDescription'] as String,
        difficulty: json['difficulty'] as String,
        duration: json['duration'] as String,
        topics: List<String>.from(json['topics'] ?? []),
        isCustom: json['isCustom'] ?? false,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
      );
    } catch (e) {
      throw FormatException('Invalid InterviewItem JSON: $e');
    }
  }

  // Copy with method for easy updates
  InterviewItem copyWith({
    String? id,
    String? jobTitle,
    String? company,
    String? jobDescription,
    String? difficulty,
    String? duration,
    List<String>? topics,
    bool? isCustom,
    DateTime? createdAt,
  }) {
    return InterviewItem(
      id: id ?? this.id,
      jobTitle: jobTitle ?? this.jobTitle,
      company: company ?? this.company,
      jobDescription: jobDescription ?? this.jobDescription,
      difficulty: difficulty ?? this.difficulty,
      duration: duration ?? this.duration,
      topics: topics ?? this.topics,
      isCustom: isCustom ?? this.isCustom,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'InterviewItem(id: $id, jobTitle: $jobTitle, company: $company, isCustom: $isCustom)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InterviewItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
