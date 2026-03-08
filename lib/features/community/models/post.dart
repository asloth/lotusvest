enum PostType { update, milestone, teamPhoto, productPreview }

class Post {
  final String id;
  final String startupId;
  final String authorName;
  final String authorPhotoUrl;
  final String content;
  final List<String> imageUrls;
  final PostType type;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final bool isLikedByUser;

  Post({
    required this.id,
    required this.startupId,
    required this.authorName,
    required this.authorPhotoUrl,
    required this.content,
    required this.imageUrls,
    required this.type,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
    this.isLikedByUser = false,
  });

  String get typeLabel {
    switch (type) {
      case PostType.update:
        return 'Actualización';
      case PostType.milestone:
        return 'Logro';
      case PostType.teamPhoto:
        return 'Equipo';
      case PostType.productPreview:
        return 'Producto';
    }
  }

  String get timeAgo {
    final difference = DateTime.now().difference(createdAt);
    if (difference.inDays > 0) {
      return 'hace ${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return 'hace ${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return 'hace ${difference.inMinutes}m';
    }
    return 'ahora';
  }
}

class Comment {
  final String id;
  final String postId;
  final String authorName;
  final String authorPhotoUrl;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.postId,
    required this.authorName,
    required this.authorPhotoUrl,
    required this.content,
    required this.createdAt,
  });
}
