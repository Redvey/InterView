// features/auth/models/user_model.dart
class User {
  String? id;
  String? email;
  String? password;
  String? fullName;
  int? age;
  String? gender;
  String? phone;
  String? college;
  String? degree;
  String? graduationYear;
  String? currentPosition;
  String? experience;
  String? referralId;
  List<String> skills;
  String? linkedinProfile;
  String? githubProfile;
  String? profilePicture; // Added profile picture field
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.email,
    this.password,
    this.fullName,
    this.age,
    this.gender,
    this.phone,
    this.college,
    this.degree,
    this.graduationYear,
    this.currentPosition,
    this.experience,
    this.referralId,
    this.skills = const [],
    this.linkedinProfile,
    this.githubProfile,
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
  });

  // Convert User to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'age': age,
      'gender': gender,
      'phone': phone,
      'college': college,
      'degree': degree,
      'graduationYear': graduationYear,
      'currentPosition': currentPosition,
      'experience': experience,
      'referralId': referralId,
      'skills': skills,
      'linkedinProfile': linkedinProfile,
      'githubProfile': githubProfile,
      'profilePicture': profilePicture,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Create User from Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      fullName: map['fullName'],
      age: map['age'],
      gender: map['gender'],
      phone: map['phone'],
      college: map['college'],
      degree: map['degree'],
      graduationYear: map['graduationYear'],
      currentPosition: map['currentPosition'],
      experience: map['experience'],
      referralId: map['referralId'],
      skills: List<String>.from(map['skills'] ?? []),
      linkedinProfile: map['linkedinProfile'],
      githubProfile: map['githubProfile'],
      profilePicture: map['profilePicture'],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  // Create a copy with updated fields
  User copyWith({
    String? id,
    String? email,
    String? password,
    String? fullName,
    int? age,
    String? gender,
    String? phone,
    String? college,
    String? degree,
    String? graduationYear,
    String? currentPosition,
    String? experience,
    String? referralId,
    List<String>? skills,
    String? linkedinProfile,
    String? githubProfile,
    String? profilePicture,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      college: college ?? this.college,
      degree: degree ?? this.degree,
      graduationYear: graduationYear ?? this.graduationYear,
      currentPosition: currentPosition ?? this.currentPosition,
      experience: experience ?? this.experience,
      referralId: referralId ?? this.referralId,
      skills: skills ?? this.skills,
      linkedinProfile: linkedinProfile ?? this.linkedinProfile,
      githubProfile: githubProfile ?? this.githubProfile,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper methods for profile completion
  bool get hasBasicInfo => fullName?.isNotEmpty == true && email?.isNotEmpty == true;

  bool get hasEducationInfo => college?.isNotEmpty == true || degree?.isNotEmpty == true;

  bool get hasProfessionalInfo => currentPosition?.isNotEmpty == true || experience?.isNotEmpty == true;

  double get profileCompletionPercentage {
    // List of all field completion checks
    final fieldChecks = [
      fullName?.isNotEmpty == true,
      email?.isNotEmpty == true,
      phone?.isNotEmpty == true,
      age != null,
      gender?.isNotEmpty == true,
      college?.isNotEmpty == true,
      degree?.isNotEmpty == true,
      graduationYear?.isNotEmpty == true,
      currentPosition?.isNotEmpty == true,
      experience?.isNotEmpty == true,
      skills.isNotEmpty,
      linkedinProfile?.isNotEmpty == true,
      githubProfile?.isNotEmpty == true,
      profilePicture?.isNotEmpty == true,
      referralId?.isNotEmpty == true,
    ];

    // Count filled fields and calculate percentage
    final filledFields = fieldChecks.where((check) => check).length;
    final totalFields = fieldChecks.length;

    return filledFields / totalFields;
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, fullName: $fullName, college: $college}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}