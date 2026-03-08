import 'package:flutter/material.dart';

class PitchProject {
  final String id;
  final String name;
  final String founderName;
  final String founderPhotoUrl;
  final String thumbnailUrl;
  final String description;
  final String category;
  final Color categoryColor;
  final List<String> techStack;
  final double fundingGoal;
  final double currentFunding;
  final int backersCount;
  final int daysLeft;

  PitchProject({
    required this.id,
    required this.name,
    required this.founderName,
    required this.founderPhotoUrl,
    required this.thumbnailUrl,
    required this.description,
    required this.category,
    required this.categoryColor,
    required this.techStack,
    required this.fundingGoal,
    required this.currentFunding,
    required this.backersCount,
    required this.daysLeft,
  });

  double get fundingProgress => currentFunding / fundingGoal;

  /// Convierte PitchProject a JSON para Firebase
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'founderName': founderName,
      'founderPhotoUrl': founderPhotoUrl,
      'thumbnailUrl': thumbnailUrl,
      'description': description,
      'category': category,
      'categoryColorValue': categoryColor.value,
      'techStack': techStack,
      'fundingGoal': fundingGoal,
      'currentFunding': currentFunding,
      'backersCount': backersCount,
      'daysLeft': daysLeft,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  /// Crea un PitchProject desde JSON de Firebase
  factory PitchProject.fromFirestore(Map<String, dynamic> data) {
    return PitchProject(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      founderName: data['founderName'] ?? '',
      founderPhotoUrl: data['founderPhotoUrl'] ?? '',
      thumbnailUrl: data['thumbnailUrl'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      categoryColor: Color(data['categoryColorValue'] ?? 0xFF8B5CF6),
      techStack: List<String>.from(data['techStack'] ?? []),
      fundingGoal: (data['fundingGoal'] ?? 0).toDouble(),
      currentFunding: (data['currentFunding'] ?? 0).toDouble(),
      backersCount: data['backersCount'] ?? 0,
      daysLeft: data['daysLeft'] ?? 0,
    );
  }
}
