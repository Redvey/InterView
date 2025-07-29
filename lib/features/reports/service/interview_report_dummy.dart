import '../model/interview_report_model.dart';

Future<List<InterviewReport>> fetchInterviewReports() async {
  await Future.delayed(const Duration(seconds: 1)); // Simulate fetch delay

  return [
    InterviewReport(
      role: "Flutter Developer (Dart Fundamentals)",
      topics: "Dart Language, OOP, Data Structures, Dart Mixins, SOLID Principles, Exception Handling",
      submittedAt: DateTime.now().subtract(const Duration(minutes: 8)),
    ),
    InterviewReport(
      role: "Android Developer (Advanced Kotlin)",
      topics: "Kotlin, Generics, Nested Classes, Abstract Classes, Functional Programming",
      submittedAt: DateTime.now().subtract(const Duration(hours: 11)),
    ),
    InterviewReport(
      role: "C++ Developer (Basic Syntax and Data Types)",
      topics: "C++ Syntax, Data Types, Variables, Operators, Control Structures",
      submittedAt: DateTime(2025, 6, 7),
    ),
    InterviewReport(
      role: "Flutter Developer (Dart Fundamentals)",
      topics: "Dart Language, OOP, Data Structures, Dart Mixins, SOLID Principles, Exception Handling",
      submittedAt: DateTime(2025, 5, 28),
    ),
  ];
}
