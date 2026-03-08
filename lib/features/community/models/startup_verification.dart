class Badge {
  final String id;
  final String name;
  final String emoji;
  final DateTime earnedAt;
  final String? issuedBy;

  Badge({
    required this.id,
    required this.name,
    required this.emoji,
    required this.earnedAt,
    this.issuedBy,
  });
}

class FounderSocial {
  final String linkedinUrl;
  final int linkedinConnections;
  final String? linkedinHeadline;
  final bool isLinkedinVerified;

  FounderSocial({
    required this.linkedinUrl,
    required this.linkedinConnections,
    this.linkedinHeadline,
    this.isLinkedinVerified = false,
  });
}

class StartupVerification {
  final String startupId;
  final bool isIdentityVerified;
  final bool isRegisteredCompany;
  final bool isDueDiligenceCompleted;
  final List<Badge> badges;
  final FounderSocial? founderSocial;
  final DateTime verifiedAt;

  StartupVerification({
    required this.startupId,
    this.isIdentityVerified = false,
    this.isRegisteredCompany = false,
    this.isDueDiligenceCompleted = false,
    this.badges = const [],
    this.founderSocial,
    required this.verifiedAt,
  });

  /// Calcula un score de confianza de 0-100 basado en las verificaciones completadas
  int get trustScore {
    int score = 0;
    if (isIdentityVerified) score += 33;
    if (isRegisteredCompany) score += 33;
    if (isDueDiligenceCompleted) score += 34;
    return score;
  }

  /// Retorna true si todas las verificaciones están completadas
  bool get isFullyVerified =>
      isIdentityVerified && isRegisteredCompany && isDueDiligenceCompleted;

  /// Retorna el número de verificaciones completadas
  int get completedVerificationsCount {
    int count = 0;
    if (isIdentityVerified) count++;
    if (isRegisteredCompany) count++;
    if (isDueDiligenceCompleted) count++;
    return count;
  }

  /// Retorna la cantidad total de verificaciones disponibles
  static const int totalVerifications = 3;
}
