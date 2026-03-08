enum ForumCategory { technology, marketStrategy, productFeedback }

class Forum {
  final String id;
  final String title;
  final ForumCategory category;
  final String description;
  final int threadsCount;
  final int membersCount;
  final DateTime lastActivity;

  Forum({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.threadsCount,
    required this.membersCount,
    required this.lastActivity,
  });

  String get categoryLabel {
    switch (category) {
      case ForumCategory.technology:
        return 'Tecnología';
      case ForumCategory.marketStrategy:
        return 'Estrategia de Mercado';
      case ForumCategory.productFeedback:
        return 'Feedback del Producto';
    }
  }

  String get categoryIcon {
    switch (category) {
      case ForumCategory.technology:
        return '💻';
      case ForumCategory.marketStrategy:
        return '📈';
      case ForumCategory.productFeedback:
        return '💬';
    }
  }
}

class ForumThread {
  final String id;
  final String forumId;
  final String title;
  final String authorName;
  final String authorPhotoUrl;
  final String preview;
  final int repliesCount;
  final int viewsCount;
  final DateTime createdAt;
  final DateTime lastReplyAt;
  final bool isPinned;

  ForumThread({
    required this.id,
    required this.forumId,
    required this.title,
    required this.authorName,
    required this.authorPhotoUrl,
    required this.preview,
    required this.repliesCount,
    required this.viewsCount,
    required this.createdAt,
    required this.lastReplyAt,
    this.isPinned = false,
  });
}

class ForumReply {
  final String id;
  final String threadId;
  final String authorName;
  final String authorPhotoUrl;
  final String content;
  final int likesCount;
  final DateTime createdAt;

  ForumReply({
    required this.id,
    required this.threadId,
    required this.authorName,
    required this.authorPhotoUrl,
    required this.content,
    required this.likesCount,
    required this.createdAt,
  });
}
