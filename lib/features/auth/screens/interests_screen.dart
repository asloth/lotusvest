import 'package:flutter/material.dart';
import 'recommended_projects_screen.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  static const _maxSelection = 4;

  final Set<int> _selected = {};

  static const _interests = [
    _Interest('Artes y Diseño', Icons.palette_outlined),
    _Interest('Tecnología', Icons.memory_outlined),
    _Interest('Espacio y Astronomía', Icons.rocket_launch_outlined),
    _Interest('Salud y Bienestar', Icons.favorite_outline),
    _Interest('Música', Icons.music_note_outlined),
    _Interest('Educación', Icons.menu_book_outlined),
    _Interest('Negocios y Finanzas', Icons.work_outline),
    _Interest('Idiomas', Icons.language_outlined),
    _Interest('Ciencia', Icons.biotech_outlined),
    _Interest('Matemáticas', Icons.calculate_outlined),
    _Interest('Cine y Medios', Icons.movie_filter_outlined),
    _Interest('Medio Ambiente', Icons.eco_outlined),
  ];

  void _toggle(int index) {
    setState(() {
      if (_selected.contains(index)) {
        _selected.remove(index);
      } else if (_selected.length < _maxSelection) {
        _selected.add(index);
      }
    });
  }

  void _handleContinue() {
    final selectedLabels = _selected
        .map((i) => _interests[i].label)
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RecommendedProjectsScreen(
          selectedInterests: selectedLabels,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                          // ── Logo ──────────────────────────────────────────
                          Image.asset(
                            'assets/icons/app_icon.webp',
                            width: 64,
                            height: 64,
                          ),
                          const SizedBox(height: 16),

                          // ── Progress dots ─────────────────────────────────
                          const _ProgressDots(activeIndex: 1),
                          const SizedBox(height: 28),

                          // ── Title ─────────────────────────────────────────
                          const Text(
                            '¿Qué te interesa?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // ── Subtitle ──────────────────────────────────────
                          Text(
                            'Selecciona hasta 4 áreas de estudio para encontrar\npersonas con intereses similares',
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

                  // ── Grid ─────────────────────────────────────────────────
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.45,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _InterestCard(
                          interest: _interests[index],
                          selected: _selected.contains(index),
                          onTap: () => _toggle(index),
                        ),
                        childCount: _interests.length,
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),

            // ── Sticky Footer ─────────────────────────────────────────────
            _StickyFooter(
              selectedCount: _selected.length,
              maxSelection: _maxSelection,
              onContinue: _handleContinue,
            ),
          ],
        ),
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
            color: isActive ? _lavender : Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Interest Card
// ─────────────────────────────────────────────────────────────────────────────
class _Interest {
  final String label;
  final IconData icon;
  const _Interest(this.label, this.icon);
}

class _InterestCard extends StatelessWidget {
  final _Interest interest;
  final bool selected;
  final VoidCallback onTap;

  static const _lavender = Color(0xFFA78BFA);

  const _InterestCard({
    required this.interest,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected
              ? _lavender.withValues(alpha: 0.15)
              : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? _lavender.withValues(alpha: 0.8)
                : Colors.white.withValues(alpha: 0.1),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              interest.icon,
              color: selected ? _lavender : Colors.white.withValues(alpha: 0.6),
              size: 22,
            ),
            const SizedBox(height: 8),
            Text(
              interest.label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.white.withValues(alpha: 0.85),
                fontSize: 13,
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.w400,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sticky Footer
// ─────────────────────────────────────────────────────────────────────────────
class _StickyFooter extends StatelessWidget {
  final int selectedCount;
  final int maxSelection;
  final VoidCallback onContinue;

  static const _lavender = Color(0xFFA78BFA);

  const _StickyFooter({
    required this.selectedCount,
    required this.maxSelection,
    required this.onContinue,
  });

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
                'Continuar ($selectedCount/$maxSelection seleccionados)',
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
            'Siempre puedes actualizar tus intereses más tarde en la configuración',
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
