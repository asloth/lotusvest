import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/profile_service.dart';
import '../../community/models/models.dart';
import '../../community/widgets/post_card.dart';

class ProfileScreen extends StatefulWidget {
  /// Pass a [profile] to view someone else's profile.
  /// Omit (null) to show the current user's own profile.
  final UserProfile? profile;

  const ProfileScreen({super.key, this.profile});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color _primary = Color(0xFFA78BFA);
  static const Color _bg = Color(0xFF121212);
  static const Color _surface = Color(0xFF1E1E1E);
  static const Color _surface2 = Color(0xFF2A2A2A);

  late UserProfile _profile;
  late List<Post> _posts;
  late List<Startup> _startups;

  bool _isFollowing = false;
  bool _isConnected = false;
  bool _messageSent = false;

  bool get _isOwnProfile => widget.profile == null;

  @override
  void initState() {
    super.initState();
    _profile = widget.profile ?? ProfileService.getMockCurrentUser();
    _isFollowing = _profile.isFollowedByCurrentUser;
    _isConnected = _profile.isConnectedToCurrentUser;
    _posts = ProfileService.getPostsForUser(_profile.id);
    _startups = ProfileService.getStartupsForUser(_profile.startupIds);
  }

  // ── helpers ──────────────────────────────────────────────────────────────

  String _formatCount(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }

  Color _socialColor(String platform) =>
      platform == 'github' ? const Color(0xFF6E7681) : const Color(0xFF0A66C2);

  IconData _socialIcon(String platform) =>
      platform == 'github' ? Icons.code : Icons.work_outline;

  String _industryEmoji(Industry industry) {
    switch (industry) {
      case Industry.fintech:
        return '💳';
      case Industry.healthtech:
        return '🏥';
      case Industry.edtech:
        return '📚';
      case Industry.ai:
        return '🤖';
      case Industry.ecommerce:
        return '🛒';
      case Industry.sustainability:
        return '🌱';
      case Industry.socialImpact:
        return '🤝';
      case Industry.other:
        return '💡';
    }
  }

  // ── actions ──────────────────────────────────────────────────────────────

  void _onFollow() => setState(() => _isFollowing = !_isFollowing);

  void _onConnect() {
    if (!_isConnected) {
      setState(() => _isConnected = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Solicitud de conexión enviada a ${_profile.name}'),
          backgroundColor: _surface2,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _onMessage() {
    if (!_messageSent) {
      setState(() => _messageSent = true);
      _showMessageSheet();
    }
  }

  void _showMessageSheet() {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(_profile.photoUrl),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mensaje a ${_profile.name.split(' ').first}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      _profile.subheader,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              autofocus: true,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Escribe tu mensaje...',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: _surface2,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Mensaje enviado a ${_profile.name.split(' ').first} ✓',
                      ),
                      backgroundColor: _surface2,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text(
                  'Enviar mensaje',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Center(child: _buildAvatar()),
                const SizedBox(height: 16),
                _buildStats(),
                if (!_isOwnProfile) _buildActionButtons(),
                if (_isOwnProfile) _buildEditButton(),
                const SizedBox(height: 8),
                _buildBio(),
                _buildSocialLinks(),
                if (_startups.isNotEmpty) _buildStartups(),
                _buildPostsSection(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── app bar (toolbar only, no cover) ─────────────────────────────────────

  Widget _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: _bg,
      leading: _isOwnProfile
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.maybePop(context),
            ),
      actions: [
        if (_isOwnProfile)
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white70),
            onPressed: () {},
          ),
        if (!_isOwnProfile)
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white70),
            onPressed: () {},
          ),
      ],
    );
  }

  // ── avatar ────────────────────────────────────────────────────────────────

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 48,
      backgroundImage: NetworkImage(_profile.photoUrl),
    );
  }

  // ── stats row ─────────────────────────────────────────────────────────────

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _profile.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _profile.subheader,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFA78BFA),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _statItem(_formatCount(_profile.connectionsCount), 'Conexiones'),
              const SizedBox(width: 32),
              _statItem(_formatCount(_profile.followingCount), 'Siguiendo'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: Colors.white38, fontSize: 12),
        ),
      ],
    );
  }

  // ── action buttons (other user) ───────────────────────────────────────────

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          // Conectar
          Expanded(
            child: _ActionButton(
              label: _isConnected ? 'Conectado ✓' : 'Conectar',
              icon: _isConnected ? Icons.people : Icons.person_add_outlined,
              filled: !_isConnected,
              onTap: _onConnect,
            ),
          ),
          const SizedBox(width: 12),
          // Mensaje
          Expanded(
            child: _ActionButton(
              label: 'Mensaje',
              icon: Icons.send_outlined,
              filled: false,
              onTap: _onMessage,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: _ActionButton(
        label: 'Editar perfil',
        icon: Icons.edit_outlined,
        filled: false,
        onTap: () {},
        fullWidth: true,
      ),
    );
  }

  // ── bio ───────────────────────────────────────────────────────────────────

  Widget _buildBio() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Text(
        _profile.bio,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
          height: 1.6,
        ),
      ),
    );
  }

  // ── social links ──────────────────────────────────────────────────────────

  Widget _buildSocialLinks() {
    if (_profile.socialLinks.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Wrap(
        spacing: 10,
        runSpacing: 8,
        children: _profile.socialLinks.map(_buildSocialChip).toList(),
      ),
    );
  }

  Widget _buildSocialChip(SocialLink link) {
    final color = _socialColor(link.platform);
    final icon = _socialIcon(link.platform);
    final label =
        link.platform == 'github' ? 'GitHub' : 'LinkedIn';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(
            '$label · @${link.handle}',
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ── startups ──────────────────────────────────────────────────────────────

  Widget _buildStartups() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 28, 20, 12),
          child: Text(
            'Startups',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 148,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: _startups.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (_, i) => _StartupCard(
              startup: _startups[i],
              industryEmoji: _industryEmoji(_startups[i].industry),
            ),
          ),
        ),
      ],
    );
  }

  // ── posts ─────────────────────────────────────────────────────────────────

  Widget _buildPostsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 28, 20, 4),
          child: Text(
            'Publicaciones',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (_posts.isEmpty)
          const Padding(
            padding: EdgeInsets.all(32),
            child: Center(
              child: Text(
                'Sin publicaciones aún',
                style: TextStyle(color: Colors.white38),
              ),
            ),
          )
        else
          ..._posts.map((p) => PostCard(post: p)),
      ],
    );
  }
}

// ── reusable action button ────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;
  final bool fullWidth;

  static const Color _primary = Color(0xFFA78BFA);
  static const Color _surface2 = Color(0xFF2A2A2A);

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: filled ? _primary : _surface2,
            borderRadius: BorderRadius.circular(14),
            border: filled ? null : Border.all(color: _primary.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: filled ? Colors.white : _primary,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: filled ? Colors.white : _primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── startup card ──────────────────────────────────────────────────────────────

class _StartupCard extends StatelessWidget {
  final Startup startup;
  final String industryEmoji;

  static const Color _surface = Color(0xFF1E1E1E);
  static const Color _primary = Color(0xFFA78BFA);

  const _StartupCard({required this.startup, required this.industryEmoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(industryEmoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  startup.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            startup.description,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            children: [
              _badge(startup.stageLabel, _primary),
              const SizedBox(width: 6),
              _badge(startup.industryLabel, const Color(0xFF34D399)),
            ],
          ),
          const SizedBox(height: 8),
          // funding bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: startup.fundingProgress.clamp(0.0, 1.0),
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation(_primary),
              minHeight: 5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${(startup.fundingProgress * 100).toStringAsFixed(0)}% fondeado',
            style: const TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _badge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
