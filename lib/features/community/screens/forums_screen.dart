import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/community_service.dart';
import '../widgets/forum_card.dart';

class ForumsScreen extends StatefulWidget {
  const ForumsScreen({super.key});

  @override
  State<ForumsScreen> createState() => _ForumsScreenState();
}

class _ForumsScreenState extends State<ForumsScreen> {
  final List<Forum> _forums = CommunityService.getMockForums();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      },
      color: const Color(0xFF6B4EFF),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ForumCard(
                forum: _forums[index],
                onTap: () => _openForum(context, _forums[index]),
              );
            }, childCount: _forums.length),
          ),
          SliverToBoxAdapter(child: _buildTrendingTopics()),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Foros de Discusión',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Conecta con otras fundadoras y miembros de la comunidad',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar en foros...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey[400]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingTopics() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.trending_up, color: Color(0xFF6B4EFF)),
              SizedBox(width: 8),
              Text(
                'Temas Trending',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTrendingItem('#MujeresEnTech', '234 publicaciones'),
          _buildTrendingItem('#PreSeedFunding', '156 publicaciones'),
          _buildTrendingItem('#AIstartups', '189 publicaciones'),
          _buildTrendingItem('#ProductMarketFit', '98 publicaciones'),
        ],
      ),
    );
  }

  Widget _buildTrendingItem(String tag, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF6B4EFF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.tag, color: Color(0xFF6B4EFF), size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tag, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(
                  count,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey[400]),
        ],
      ),
    );
  }

  void _openForum(BuildContext context, Forum forum) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForumDetailScreen(forum: forum)),
    );
  }
}

class ForumDetailScreen extends StatelessWidget {
  final Forum forum;

  const ForumDetailScreen({super.key, required this.forum});

  @override
  Widget build(BuildContext context) {
    final threads = CommunityService.getMockThreads(forum.id);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B4EFF),
        foregroundColor: Colors.white,
        title: Text(forum.title),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {})],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: threads.length,
        itemBuilder: (context, index) {
          final thread = threads[index];
          return _buildThreadCard(thread);
        },
      ),
    );
  }

  Widget _buildThreadCard(ForumThread thread) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (thread.isPinned)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.push_pin, size: 14, color: Colors.amber[800]),
                  const SizedBox(width: 4),
                  Text(
                    'Fijado',
                    style: TextStyle(
                      color: Colors.amber[800],
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          Text(
            thread.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            thread.preview,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundImage: NetworkImage(thread.authorPhotoUrl),
              ),
              const SizedBox(width: 8),
              Text(
                thread.authorName,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const Spacer(),
              Icon(
                Icons.chat_bubble_outline,
                size: 14,
                color: Colors.grey[400],
              ),
              const SizedBox(width: 4),
              Text(
                '${thread.repliesCount}',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.visibility_outlined,
                size: 14,
                color: Colors.grey[400],
              ),
              const SizedBox(width: 4),
              Text(
                '${thread.viewsCount}',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
