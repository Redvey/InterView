class ProfileData {
  final String? fullName;
  final String? email;
  final String? phone;
  final String? location;
  final String? jobTitle;
  final String? experience;
  final List<String>? skills;
  final String? education;
  final String? summary;
  final String? resumeFileName;
  final int? resumeSize;

  ProfileData({
    this.fullName,
    this.email,
    this.phone,
    this.location,
    this.jobTitle,
    this.experience,
    this.skills,
    this.education,
    this.summary,
    this.resumeFileName,
    this.resumeSize,
  });

  factory ProfileData.fromMap(Map<String, dynamic> map) {
    return ProfileData(
      fullName: map['fullName'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      location: map['location'] as String?,
      jobTitle: map['jobTitle'] as String?,
      experience: map['experience'] as String?,
      skills: map['skills'] != null ? List<String>.from(map['skills']) : null,
      education: map['education'] as String?,
      summary: map['summary'] as String?,
      resumeFileName: map['resumeFileName'] as String?,
      resumeSize: map['resumeSize'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'location': location,
      'jobTitle': jobTitle,
      'experience': experience,
      'skills': skills,
      'education': education,
      'summary': summary,
      'resumeFileName': resumeFileName,
      'resumeSize': resumeSize,
    };
  }

  ProfileData copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? location,
    String? jobTitle,
    String? experience,
    List<String>? skills,
    String? education,
    String? summary,
    String? resumeFileName,
    int? resumeSize,
  }) {
    return ProfileData(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      jobTitle: jobTitle ?? this.jobTitle,
      experience: experience ?? this.experience,
      skills: skills ?? this.skills,
      education: education ?? this.education,
      summary: summary ?? this.summary,
      resumeFileName: resumeFileName ?? this.resumeFileName,
      resumeSize: resumeSize ?? this.resumeSize,
    );
  }

  bool get hasValidBasicInfo {
    return (fullName?.isNotEmpty == true) ||
        (email?.isNotEmpty == true && email!.contains('@'));
  }

  bool get hasValidContactInfo {
    return hasValidBasicInfo &&
        (phone?.isNotEmpty == true || location?.isNotEmpty == true);
  }

  bool get hasValidProfessionalInfo {
    return (skills?.isNotEmpty == true) ||
        (summary?.isNotEmpty == true) ||
        (jobTitle?.isNotEmpty == true);
  }

  bool get isComplete {
    return hasValidBasicInfo && hasValidProfessionalInfo;
  }

  @override
  String toString() {
    return 'ProfileData(fullName: $fullName, email: $email, phone: $phone, '
        'location: $location, jobTitle: $jobTitle, experience: $experience, '
        'skills: $skills, education: $education, summary: $summary, '
        'resumeFileName: $resumeFileName, resumeSize: $resumeSize)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProfileData &&
        other.fullName == fullName &&
        other.email == email &&
        other.phone == phone &&
        other.location == location &&
        other.jobTitle == jobTitle &&
        other.experience == experience &&
        _listEquals(other.skills, skills) &&
        other.education == education &&
        other.summary == summary &&
        other.resumeFileName == resumeFileName &&
        other.resumeSize == resumeSize;
  }

  @override
  int get hashCode {
    return Object.hash(
      fullName,
      email,
      phone,
      location,
      jobTitle,
      experience,
      skills,
      education,
      summary,
      resumeFileName,
      resumeSize,
    );
  }

  static bool _listEquals(List<String>? a, List<String>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

class ResumeExtractionResult {
  final bool isSuccessful;
  final ProfileData? profileData;
  final String? errorMessage;
  final DateTime extractedAt;
  final String fileName;
  final int fileSize;

  ResumeExtractionResult({
    required this.isSuccessful,
    this.profileData,
    this.errorMessage,
    required this.extractedAt,
    required this.fileName,
    required this.fileSize,
  });

  factory ResumeExtractionResult.success({
    required ProfileData profileData,
    required String fileName,
    required int fileSize,
  }) {
    return ResumeExtractionResult(
      isSuccessful: true,
      profileData: profileData,
      extractedAt: DateTime.now(),
      fileName: fileName,
      fileSize: fileSize,
    );
  }

  factory ResumeExtractionResult.failure({
    required String errorMessage,
    required String fileName,
    required int fileSize,
  }) {
    return ResumeExtractionResult(
      isSuccessful: false,
      errorMessage: errorMessage,
      extractedAt: DateTime.now(),
      fileName: fileName,
      fileSize: fileSize,
    );
  }

  @override
  String toString() {
    return 'ResumeExtractionResult(isSuccessful: $isSuccessful, '
        'profileData: $profileData, errorMessage: $errorMessage, '
        'extractedAt: $extractedAt, fileName: $fileName, fileSize: $fileSize)';
  }
}