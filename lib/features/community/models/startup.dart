import 'startup_verification.dart';
import 'post.dart';

enum StartupStage { ideation, preSeed, seed }

enum Industry {
  fintech,
  healthtech,
  edtech,
  ai,
  ecommerce,
  sustainability,
  socialImpact,
  other,
}

class Startup {
  final String id;
  final String name;
  final String description;
  final String founderName;
  final String founderPhotoUrl;
  final String logoUrl;
  final Industry industry;
  final StartupStage stage;
  final List<String> technologies;
  final double fundingGoal;
  final double currentFunding;
  final int membersCount;
  final DateTime createdAt;
  final int investorsCount;
  final int? daysRemaining;
  final StartupVerification? verification;
  final List<Post> posts;

  Startup({
    required this.id,
    required this.name,
    required this.description,
    required this.founderName,
    required this.founderPhotoUrl,
    required this.logoUrl,
    required this.industry,
    required this.stage,
    required this.technologies,
    required this.fundingGoal,
    required this.currentFunding,
    required this.membersCount,
    required this.createdAt,
    this.investorsCount = 0,
    this.daysRemaining,
    this.verification,
    this.posts = const [],
  });

  double get fundingProgress => currentFunding / fundingGoal;

  String get industryLabel {
    switch (industry) {
      case Industry.fintech:
        return 'Fintech';
      case Industry.healthtech:
        return 'HealthTech';
      case Industry.edtech:
        return 'EdTech';
      case Industry.ai:
        return 'Inteligencia Artificial';
      case Industry.ecommerce:
        return 'E-Commerce';
      case Industry.sustainability:
        return 'Sustentabilidad';
      case Industry.socialImpact:
        return 'Impacto Social';
      case Industry.other:
        return 'Otro';
    }
  }

  String get stageLabel {
    switch (stage) {
      case StartupStage.ideation:
        return 'Ideación';
      case StartupStage.preSeed:
        return 'Pre-Seed';
      case StartupStage.seed:
        return 'Seed';
    }
  }
}
