import 'package:flutter/material.dart';

enum DifficultyLevel {
  easy('Easy', Colors.green),
  medium('Medium', Colors.orange),
  hard('Hard', Colors.red);

  final String displayName;
  final Color color;

  const DifficultyLevel(this.displayName, this.color);

  static DifficultyLevel fromString(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return DifficultyLevel.easy;
      case 'medium':
        return DifficultyLevel.medium;
      case 'hard':
        return DifficultyLevel.hard;
      default:
        return DifficultyLevel.medium;
    }
  }
}