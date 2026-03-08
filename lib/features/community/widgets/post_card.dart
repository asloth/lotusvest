import 'package:flutter/material.dart';
import '../models/models.dart';

class PostCard extends StatelessWidget {
  final Post post;

  // Theme colors
  static const Color _primaryColor = Color(0xFFA78BFA);
  static const Color _surfaceColor = Color(0xFF1E1E1E);

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildContent(),
          if (post.imageUrls.isNotEmpty) _buildImages(),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(post.authorPhotoUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      post.authorName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getTypeColor().withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        post.typeLabel,
                        style: TextStyle(
                          color: _getTypeColor(),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  post.timeAgo,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white38),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Color _getTypeColor() {
    switch (post.type) {
      case PostType.milestone:
        return const Color(0xFFFFD93D);
      case PostType.teamPhoto:
        return const Color(0xFF60A5FA);
      case PostType.productPreview:
        return _primaryColor;
      case PostType.update:
        return const Color(0xFF34D399);
    }
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        post.content,
        style: const TextStyle(
          fontSize: 14,
          height: 1.5,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget _buildImages() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(post.imageUrls.first),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildActionButton(
            post.isLikedByUser ? Icons.favorite : Icons.favorite_border,
            '${post.likesCount}',
            post.isLikedByUser ? const Color(0xFFFF6B6B) : Colors.white54,
          ),
          const SizedBox(width: 24),
          _buildActionButton(
            Icons.chat_bubble_outline,
            '${post.commentsCount}',
            Colors.white54,
          ),
          const SizedBox(width: 24),
          _buildActionButton(
            Icons.share_outlined,
            'Compartir',
            Colors.white54,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.favorite, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  'Apoyar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: color, fontSize: 13)),
      ],
    );
  }
}
