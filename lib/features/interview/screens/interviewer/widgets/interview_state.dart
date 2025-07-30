// lib/features/interview/models/interview_state.dart
import 'package:flutter/material.dart';

class InterviewState {
  final int currentQuestion;
  final int totalQuestions;
  final int confidenceScore;
  final String eyeContact;
  final String posture;
  final bool isRecording;

  const InterviewState({
    required this.currentQuestion,
    required this.totalQuestions,
    required this.confidenceScore,
    required this.eyeContact,
    required this.posture,
    required this.isRecording,
  });

  InterviewState copyWith({
    int? currentQuestion,
    int? totalQuestions,
    int? confidenceScore,
    String? eyeContact,
    String? posture,
    bool? isRecording,
  }) {
    return InterviewState(
      currentQuestion: currentQuestion ?? this.currentQuestion,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      eyeContact: eyeContact ?? this.eyeContact,
      posture: posture ?? this.posture,
      isRecording: isRecording ?? this.isRecording,
    );
  }

  Color getConfidenceColor() {
    if (confidenceScore >= 80) return const Color(0xFF4CAF50);
    if (confidenceScore >= 60) return const Color(0xFF2196F3);
    if (confidenceScore >= 40) return const Color(0xFFFFC107);
    return const Color(0xFFFF5722);
  }

  String getConfidenceLabel() {
    if (confidenceScore >= 80) return 'Excellent';
    if (confidenceScore >= 60) return 'Good';
    if (confidenceScore >= 40) return 'Fair';
    return 'Needs Work';
  }

  Color getPostureColor() {
    switch (posture.toLowerCase()) {
      case 'excellent':
      case 'good':
        return const Color(0xFF4CAF50);
      case 'fair':
        return const Color(0xFFFFC107);
      default:
        return const Color(0xFFFF5722);
    }
  }

  Color getEyeContactColor() {
    switch (eyeContact.toLowerCase()) {
      case 'maintained':
      case 'good':
        return const Color(0xFF4CAF50);
      case 'fair':
        return const Color(0xFFFFC107);
      default:
        return const Color(0xFFFF5722);
    }
  }
}