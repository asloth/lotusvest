import 'package:flutter/material.dart';
import 'people_to_connect_screen.dart';

class RecommendedProjectsScreen extends StatefulWidget {
  final List<String> selectedInterests;

  const RecommendedProjectsScreen({
    super.key,
    required this.selectedInterests,
  });

  @override
  State<RecommendedProjectsScreen> createState() =>
      _RecommendedProjectsScreenState();
}

class _RecommendedProjectsScreenState
    extends State<RecommendedProjectsScreen> {
  static const _lavender = Color(0xFFA78BFA);

  final Set<String> _joined = {};

  static final _allProjects = [
    _Project(
      id: 'p1',
      name: 'EduTech Latam',
      description:
          'Plataforma de aprendizaje adaptativo para comunidades rurales en América Latina.',
      tags: ['Educación', 'Tecnología'],
      memberCount: 128,
      stage: 'Pre-seed',
      color: const Color(0xFF6366F1),
      initial: 'E',
    ),
    _Project(
      id: 'p2',
      name: 'HealthFlow',
      description:
          'App de bienestar y seguimiento de salud preventiva para mujeres emprendedoras.',
      tags: ['Salud y Bienestar', 'Tecnología'],
      memberCount: 89,
      stage: 'Ideación',
      color: const Color(0xFF10B981),
      initial: 'H',
    ),
    _Project(
      id: 'p3',
      name: 'ArtConnect',
      description:
          'Marketplace de arte digital y conexión entre artistas y coleccionistas.',
      tags: ['Artes y Diseño', 'Cine y Medios'],
      memberCount: 214,
      stage: 'Seed',
      color: const Color(0xFFF59E0B),
      initial: 'A',
    ),
    _Project(
      id: 'p4',
      name: 'FinaHer',
      description:
          'Microcréditos y educación financiera diseñados para emprendedoras en Latinoamérica.',
      tags: ['Negocios y Finanzas', 'Tecnología'],
      memberCount: 156,
      stage: 'Pre-seed',
      color: _lavender,
      initial: 'F',
    ),
    _Project(
      id: 'p5',
      name: 'GreenStartup',
      description:
          'Soluciones de economía circular para reducir residuos en PyMEs de la región.',
      tags: ['Medio Ambiente', 'Ciencia'],
      memberCount: 73,
      stage: 'Ideación',
      color: const Color(0xFF059669),
      initial: 'G',
    ),
    _Project(
      id: 'p6',
      name: 'SoundVenture',
      description:
          'Plataforma de distribución musical independiente para artistas emergentes en Latam.',
      tags: ['Música', 'Negocios y Finanzas'],
      memberCount: 97,
      stage: 'Pre-seed',
      color: const Color(0xFFEC4899),
      initial: 'S',
    ),
  ];

  List<_Project> get _filtered {
    final matched = _allProjects
        .where((p) => p.tags.any((t) => widget.selectedInterests.contains(t)))
        .toList();
    if (matched.length >= 3) return matched;
    return _allProjects;
  }

  void _handleContinue() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PeopleToConnectScreen(
          selectedInterests: widget.selectedInterests,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final projects = _filtered;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/icons/app_icon.webp',
                            width: 64,
                            height: 64,
                          ),
                          const SizedBox(height: 16),
                          const _ProgressDots(activeIndex: 2),
                          const SizedBox(height: 28),
                          const Text(
                            'Proyectos para ti',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Basado en tus intereses, estos proyectos\npodrían ser perfectos para ti',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 13,
                              height: 1.55,
                            ),
                          ),
                          const SizedBox(height: 28),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final p = projects[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _ProjectCard(
                              project: p,
                              joined: _joined.contains(p.id),
                              onJoin: () => setState(() {
                                if (_joined.contains(p.id)) {
                                  _joined.remove(p.id);
                                } else {
                                  _joined.add(p.id);
                                }
                              }),
                            ),
                          );
                        },
                        childCount: projects.length,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),
            _Footer(
              joinedCount: _joined.length,
              onContinue: _handleContinue,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Project Card
// ─────────────────────────────────────────────────────────────────────────────
class _Project {
  final String id;
  final String name;
  final String description;
  final List<String> tags;
  final int memberCount;
  final String stage;
  final Color color;
  final String initial;

  const _Project({
    required this.id,
    required this.name,
    required this.description,
    required this.tags,
    required this.memberCount,
    required this.stage,
    required this.color,
    required this.initial,
  });
}

class _ProjectCard extends StatelessWidget {
  final _Project project;
  final bool joined;
  final VoidCallback onJoin;

  static const _lavender = Color(0xFFA78BFA);

  const _ProjectCard({
    required this.project,
    required this.joined,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: joined
              ? _lavender.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: project.color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: project.color.withValues(alpha: 0.4),
              ),
            ),
            child: Center(
              child: Text(
                project.initial,
                style: TextStyle(
                  color: project.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Stage
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        project.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        project.stage,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.55),
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  project.description,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.55),
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 10),
                // Tags
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: project.tags
                      .map(
                        (t) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: _lavender.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            t,
                            style: TextStyle(
                              color: _lavender.withValues(alpha: 0.9),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 12),
                // Bottom row
                Row(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 14,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${project.memberCount} miembros',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onJoin,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 7),
                        decoration: BoxDecoration(
                          color: joined
                              ? _lavender
                              : _lavender.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: joined
                                ? _lavender
                                : _lavender.withValues(alpha: 0.35),
                          ),
                        ),
                        child: Text(
                          joined ? 'Unido ✓' : 'Unirse',
                          style: TextStyle(
                            color: joined
                                ? Colors.white
                                : _lavender,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Footer
// ─────────────────────────────────────────────────────────────────────────────
class _Footer extends StatelessWidget {
  final int joinedCount;
  final VoidCallback onContinue;

  static const _lavender = Color(0xFFA78BFA);

  const _Footer({required this.joinedCount, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 52,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: _lavender,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                joinedCount > 0
                    ? 'Continuar ($joinedCount unidos)'
                    : 'Continuar',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Puedes explorar más proyectos desde la comunidad',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.35),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Progress Dots
// ─────────────────────────────────────────────────────────────────────────────
class _ProgressDots extends StatelessWidget {
  final int activeIndex;
  static const _total = 4;
  static const _lavender = Color(0xFFA78BFA);

  const _ProgressDots({required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_total, (i) {
        final isActive = i == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 20 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: isActive
                ? _lavender
                : i < activeIndex
                    ? _lavender.withValues(alpha: 0.45)
                    : Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
