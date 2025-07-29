class InterviewReport {
  final String role;
  final List<String> topics;
  final DateTime submittedAt;

  InterviewReport({
    required this.role,
    required this.topics,
    required this.submittedAt,
  });

  // Equality override
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InterviewReport &&
        other.role == role &&
        _listEquals(other.topics, topics) &&
        other.submittedAt == submittedAt;
  }

  @override
  int get hashCode => role.hashCode ^ topics.hashCode ^ submittedAt.hashCode;

  // toString override
  @override
  String toString() =>
      'InterviewReport(role: $role, topics: $topics, submittedAt: $submittedAt)';

  // copyWith method
  InterviewReport copyWith({
    String? role,
    List<String>? topics,
    DateTime? submittedAt,
  }) {
    return InterviewReport(
      role: role ?? this.role,
      topics: topics ?? this.topics,
      submittedAt: submittedAt ?? this.submittedAt,
    );
  }

  // Helper for comparing lists
  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
