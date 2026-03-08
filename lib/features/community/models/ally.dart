enum AllyOfferType { mentorship, funding, networking, expertise }

class Ally {
  final String id;
  final String name;
  final String photoUrl;
  final String title;
  final String company;
  final String bio;
  final List<AllyOfferType> offerTypes;
  final List<String> expertise;
  final int connectionsCount;
  final bool isVerified;
  final DateTime joinedAt;

  Ally({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.title,
    required this.company,
    required this.bio,
    required this.offerTypes,
    required this.expertise,
    required this.connectionsCount,
    this.isVerified = false,
    required this.joinedAt,
  });

  String getOfferTypeLabel(AllyOfferType type) {
    switch (type) {
      case AllyOfferType.mentorship:
        return 'Mentoría';
      case AllyOfferType.funding:
        return 'Financiamiento';
      case AllyOfferType.networking:
        return 'Contactos';
      case AllyOfferType.expertise:
        return 'Expertise';
    }
  }
}

class AllyOffer {
  final String id;
  final String allyId;
  final String allyName;
  final String allyPhotoUrl;
  final AllyOfferType type;
  final String title;
  final String description;
  final bool isAvailable;
  final DateTime createdAt;

  AllyOffer({
    required this.id,
    required this.allyId,
    required this.allyName,
    required this.allyPhotoUrl,
    required this.type,
    required this.title,
    required this.description,
    required this.isAvailable,
    required this.createdAt,
  });

  String get typeLabel {
    switch (type) {
      case AllyOfferType.mentorship:
        return 'Mentoría';
      case AllyOfferType.funding:
        return 'Financiamiento';
      case AllyOfferType.networking:
        return 'Contactos';
      case AllyOfferType.expertise:
        return 'Expertise';
    }
  }

  String get typeIcon {
    switch (type) {
      case AllyOfferType.mentorship:
        return '🎓';
      case AllyOfferType.funding:
        return '💰';
      case AllyOfferType.networking:
        return '🤝';
      case AllyOfferType.expertise:
        return '🧠';
    }
  }
}
