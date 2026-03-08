import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/models.dart';
import '../services/community_service.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  /// ID de la startup a mostrar
  final String startupId;

  const FeedScreen({super.key, this.startupId = 'startup1'});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late Startup _startup;
  late List<Post> _posts;
  final ScrollController _scrollController = ScrollController();

  // Theme colors
  static const Color _primaryColor = Color(0xFFA78BFA);
  static const Color _backgroundColor = Color(0xFF121212);
  static const Color _surfaceColor = Color(0xFF1E1E1E);
  static const Color _verifiedColor = Color(0xFF34D399);

  @override
  void initState() {
    super.initState();
    // Cargar startup del servicio
    _startup =
        CommunityService.getMockStartupById(widget.startupId) ??
        CommunityService.getMockStartups().first;
    // Obtener posts desde la startup
    _posts = _startup.posts;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _surfaceColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Detalle de la Startup',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white70),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.white70),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {});
        },
        color: _primaryColor,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(child: _buildStartupProfile()),
            SliverToBoxAdapter(child: _buildFundingProgress()),
            SliverToBoxAdapter(child: _buildTechStack()),
            SliverToBoxAdapter(child: _buildTrustIndicators()),
            SliverToBoxAdapter(child: _buildSectionHeader()),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return PostCard(post: _posts[index]);
              }, childCount: _posts.length),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showDonationBottomSheet(context);
        },
        backgroundColor: _primaryColor,
        icon: const Icon(Icons.favorite, color: Colors.white),
        label: const Text(
          'Donar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildStartupProfile() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Founder photo
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [_primaryColor, _primaryColor.withOpacity(0.5)],
                  ),
                ),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _surfaceColor, width: 3),
                    image: DecorationImage(
                      image: NetworkImage(_startup.founderPhotoUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Startup info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          _startup.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildVerifiedBadge(),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _startup.founderName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Fundadora & CEO',
                      style: TextStyle(fontSize: 12, color: _primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            _startup.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          // Stage badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.rocket_launch,
                      size: 14,
                      color: _primaryColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _startup.stage.toString().split('.').last.toUpperCase(),
                      style: const TextStyle(
                        color: _primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF60A5FA).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.category,
                      size: 14,
                      color: Color(0xFF60A5FA),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _startup.industry
                          .toString()
                          .split('.')
                          .last
                          .toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF60A5FA),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerifiedBadge() {
    // Solo mostrar si la startup está completamente verificada
    final isVerified = _startup.verification?.isFullyVerified ?? false;

    if (!isVerified) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _verifiedColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, size: 14, color: _verifiedColor),
          SizedBox(width: 4),
          Text(
            'Verificada',
            style: TextStyle(
              color: _verifiedColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFundingProgress() {
    final double goalAmount = _startup.fundingGoal;
    final double currentAmount = _startup.currentFunding;
    final double progress = currentAmount / goalAmount;
    final double remainingAmount = goalAmount - currentAmount;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Meta de Financiamiento',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    color: _primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: _backgroundColor,
              valueColor: const AlwaysStoppedAnimation<Color>(_primaryColor),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recaudado',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${currentAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                    style: const TextStyle(
                      color: _primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Faltan',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${remainingAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                    style: const TextStyle(
                      color: Color(0xFFFFD93D),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.people_outline, size: 16, color: Colors.white54),
              const SizedBox(width: 6),
              Text(
                '${_startup.investorsCount} inversores',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.access_time, size: 16, color: Colors.white54),
              const SizedBox(width: 6),
              if (_startup.daysRemaining != null)
                Text(
                  '${_startup.daysRemaining} días restantes',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                )
              else
                const Text(
                  'Campaña cerrada',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechStack() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stack Tecnológico',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _startup.technologies.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _getTechEmoji(tech),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tech,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Retorna el emoji correspondiente a una tecnología
  String _getTechEmoji(String techName) {
    const Map<String, String> techEmojis = {
      'Flutter': '📱',
      'Firebase': '🔥',
      'Python': '🐍',
      'AWS': '☁️',
      'Machine Learning': '🤖',
      'React Native': '⚛️',
      'Node.js': '🟢',
      'ML': '🤖',
      'IA': '🧠',
    };
    return techEmojis[techName] ?? '💻';
  }

  Widget _buildTrustIndicators() {
    final verification = _startup.verification;

    // Definir items de verificación de forma estructurada
    final verificationItems = [
      {
        'icon': Icons.verified_user,
        'title': 'Identidad Verificada',
        'verifiedText': 'Documentación revisada por LotusVest',
        'unverifiedText': 'Pendiente de revisión',
        'isVerified': verification?.isIdentityVerified ?? false,
      },
      {
        'icon': Icons.business,
        'title': 'Empresa Registrada',
        'verifiedText': 'RFC y acta constitutiva validados',
        'unverifiedText': 'Documentación no completada',
        'isVerified': verification?.isRegisteredCompany ?? false,
      },
      {
        'icon': Icons.account_balance,
        'title': 'Due Diligence Completado',
        'verifiedText': 'Revisión financiera aprobada',
        'unverifiedText': 'Revisión financiera pendiente',
        'isVerified': verification?.isDueDiligenceCompleted ?? false,
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.shield_outlined, size: 20, color: _verifiedColor),
              SizedBox(width: 8),
              Text(
                'Indicadores de Confianza',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Verification items dinámicos
          if (verification != null)
            ...List.generate(verificationItems.length, (index) {
              final item = verificationItems[index];
              return Column(
                children: [
                  _buildTrustItem(
                    item['icon'] as IconData,
                    item['title'] as String,
                    item['isVerified'] as bool
                        ? item['verifiedText'] as String
                        : item['unverifiedText'] as String,
                    item['isVerified'] as bool
                        ? _verifiedColor
                        : Colors.white54,
                    //isVerified: item['isVerified'] as bool,
                  ),
                  if (index < verificationItems.length - 1)
                    const SizedBox(height: 12),
                ],
              );
            }),
          const SizedBox(height: 16),
          const Divider(color: Colors.white12),
          const SizedBox(height: 16),
          // LinkedIn connection dinámico
          if (verification?.founderSocial != null)
            _buildLinkedInCard()
          else
            const Text(
              'Información de LinkedIn no disponible',
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          const SizedBox(height: 12),
          // Endorsements/Badges dinámicos
          if (verification?.badges.isNotEmpty ?? false)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: verification!.badges.map((badge) {
                return _buildEndorsementBadge(badge.emoji, badge.name);
              }).toList(),
            )
          else
            const Text(
              'Sin badges aún',
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
        ],
      ),
    );
  }

  /// Construye tarjeta de LinkedIn dinámicamente
  Widget _buildLinkedInCard() {
    final social = _startup.verification?.founderSocial;
    if (social == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () => _launchLinkedIn(social.linkedinUrl),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF0A66C2).withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF0A66C2).withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF0A66C2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.link, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LinkedIn de ${_startup.founderName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '+${social.linkedinConnections} conexiones'
                    '${social.linkedinHeadline != null ? ' • ${social.linkedinHeadline}' : ''}'
                    '${social.isLinkedinVerified ? ' ✓' : ''}',
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.open_in_new, color: Color(0xFF0A66C2), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustItem(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
        ),
        const Icon(Icons.check_circle, size: 18, color: _verifiedColor),
      ],
    );
  }

  Widget _buildEndorsementBadge(String emoji, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Avances Recientes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Ver todos',
              style: TextStyle(
                color: _primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchLinkedIn(String url) async {
    final Uri linkedinUrl = Uri.parse(url);
    try {
      await launchUrl(linkedinUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      // Handle error silently
    }
  }
}

void _showDonationBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: _FeedScreenState._surfaceColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Impulsa una Startup',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tu donación genera impacto directo en emprendedoras',
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
          const SizedBox(height: 24),
          const Text(
            'Selecciona un monto',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildAmountButton('\$10', false),
              const SizedBox(width: 12),
              _buildAmountButton('\$25', true),
              const SizedBox(width: 12),
              _buildAmountButton('\$50', false),
              const SizedBox(width: 12),
              _buildAmountButton('\$100', false),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'O ingresa otro monto',
              hintStyle: const TextStyle(color: Colors.white38),
              prefixText: '\$ ',
              prefixStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.white24),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.white24),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: _FeedScreenState._primaryColor,
                ),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _FeedScreenState._primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.security, color: _FeedScreenState._primaryColor),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Pagos seguros procesados con encriptación de grado bancario',
                    style: TextStyle(
                      fontSize: 12,
                      color: _FeedScreenState._primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Donación procesada exitosamente'),
                    backgroundColor: _FeedScreenState._primaryColor,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _FeedScreenState._primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Donar Ahora',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildAmountButton(String amount, bool selected) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: selected ? _FeedScreenState._primaryColor : Colors.transparent,
        border: Border.all(
          color: selected ? _FeedScreenState._primaryColor : Colors.white24,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          amount,
          style: TextStyle(
            color: selected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}
