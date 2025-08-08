import 'package:flutter/material.dart';

class TemplateModel {
  final String id;
  final String name;
  final IconData icon;
  final String category;
  final String? description;
  final Map<String, dynamic>? metadata; // For additional backend data
  final bool isPremium;
  final int usageCount;
  final DateTime? lastUsed;

  const TemplateModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.category,
    this.description,
    this.metadata,
    this.isPremium = false,
    this.usageCount = 0,
    this.lastUsed,
  });

  // For backend integration
  factory TemplateModel.fromJson(Map<String, dynamic> json) {
    return TemplateModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      icon: _getIconFromString(json['icon'] ?? 'info_outline'),
      category: json['category'] ?? 'general',
      description: json['description'],
      metadata: json['metadata'],
      isPremium: json['isPremium'] ?? false,
      usageCount: json['usageCount'] ?? 0,
      lastUsed: json['lastUsed'] != null
          ? DateTime.parse(json['lastUsed'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': _getStringFromIcon(icon),
      'category': category,
      'description': description,
      'metadata': metadata,
      'isPremium': isPremium,
      'usageCount': usageCount,
      'lastUsed': lastUsed?.toIso8601String(),
    };
  }

  static IconData _getIconFromString(String iconString) {
    final iconMap = {
      'info_outline': Icons.info_outline,
      'work_outline': Icons.work_outline,
      'people_outline': Icons.people_outline,
      'follow_the_signs_outlined': Icons.follow_the_signs_outlined,
      'email_outlined': Icons.email_outlined,
      'business_outlined': Icons.business_outlined,
      'handshake_outlined': Icons.handshake_outlined,
      'school_outlined': Icons.school_outlined,
    };
    return iconMap[iconString] ?? Icons.info_outline;
  }

  static String _getStringFromIcon(IconData icon) {
    final iconMap = {
      Icons.info_outline: 'info_outline',
      Icons.work_outline: 'work_outline',
      Icons.people_outline: 'people_outline',
      Icons.follow_the_signs_outlined: 'follow_the_signs_outlined',
      Icons.email_outlined: 'email_outlined',
      Icons.business_outlined: 'business_outlined',
      Icons.handshake_outlined: 'handshake_outlined',
      Icons.school_outlined: 'school_outlined',
    };
    return iconMap[icon] ?? 'info_outline';
  }

  TemplateModel copyWith({
    String? id,
    String? name,
    IconData? icon,
    String? category,
    String? description,
    Map<String, dynamic>? metadata,
    bool? isPremium,
    int? usageCount,
    DateTime? lastUsed,
  }) {
    return TemplateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      category: category ?? this.category,
      description: description ?? this.description,
      metadata: metadata ?? this.metadata,
      isPremium: isPremium ?? this.isPremium,
      usageCount: usageCount ?? this.usageCount,
      lastUsed: lastUsed ?? this.lastUsed,
    );
  }
}