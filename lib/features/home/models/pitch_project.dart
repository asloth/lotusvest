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
}
