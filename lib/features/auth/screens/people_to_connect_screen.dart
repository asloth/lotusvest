import 'package:flutter/material.dart';

class PeopleToConnectScreen extends StatefulWidget {
  final List<String> selectedInterests;

  const PeopleToConnectScreen({
    super.key,
    required this.selectedInterests,
  });

  @override
  State<PeopleToConnectScreen> createState() => _PeopleToConnectScreenState();
}

class _PeopleToConnectScreenState extends State<PeopleToConnectScreen> {
  final Set<String> _connected = {};

  static final _allPeople = [
    _Person(
      id: 'u1',
      name: 'María González',
      role: 'Fundadora · FinaHer',
      photoUrl:
          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200',
      tags: ['Negocios y Finanzas', 'Tecnología'],
      mutualConnections: 4,
    ),
    _Person(
      id: 'u2',
      name: 'Ana Rodríguez',
      role: 'Co-fundadora · MindFlow',
      photoUrl: 'https://i.pravatar.cc/150?img=5',
      tags: ['Salud y Bienestar', 'Ciencia'],
      mutualConnections: 2,
    ),
    _Person(
      id: 'u3',
      name: 'Laura Martínez',
      role: 'CEO · EduTech Latam',
      photoUrl: 'https://i.pravatar.cc/150?img=9',
      tags: ['Educación', 'Tecnología'],
      mutualConnections: 6,
    ),
    _Person(
      id: 'u4',
      name: 'Sofía Herrera',
      role: 'Directora Creativa · ArtConnect',
      photoUrl: 'https://i.pravatar.cc/150?img=23',
      tags: ['Artes y Diseño', 'Cine y Medios'],
      mutualConnections: 1,
    ),
    _Person(
      id: 'u5',
      name: 'Carmen López',
      role: 'Científica · GreenStartup',
      photoUrl: 'https://i.pravatar.cc/150?img=47',
      tags: ['Medio Ambiente', 'Ciencia'],
      mutualConnections: 3,
    ),
    _Person(
      id: 'u6',
      name: 'Isabella Torres',
      role: 'Inversora ángel · EmprendedorasMX',
      photoUrl: 'https://i.pravatar.cc/150?img=25',
      tags: ['Negocios y Finanzas', 'Idiomas'],
      mutualConnections: 5,
    ),
  ];

  List<_Person> get _sorted {
    // People with matching interests first
    final matched = _allPeople
        .where((p) => p.tags.any((t) => widget.selectedInterests.contains(t)))
        .toList()
      ..sort((a, b) {
        final aMatches = a.tags
            .where((t) => widget.selectedInterests.contains(t))
            .length;
        final bMatches = b.tags
            .where((t) => widget.selectedInterests.contains(t))
            .length;
        return bMatches.compareTo(aMatches);
      });
    final rest = _allPeople.where((p) => !matched.contains(p)).toList();
    return [...matched, ...rest];
  }

  void _handleStart() {
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final people = _sorted;

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
                          const _ProgressDots(activeIndex: 3),
                          const SizedBox(height: 28),
                          const Text(
                            'Personas que podrías\nconocer',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.3,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Conecta con fundadoras y aliadas que\ncomparten tu visión',
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
                          final person = people[index];
                          final isMatch = person.tags
                              .any((t) => widget.selectedInterests.contains(t));
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _PersonCard(
                              person: person,
                              connected: _connected.contains(person.id),
                              isMatch: isMatch,
                              sharedInterests: person.tags
                                  .where((t) =>
                                      widget.selectedInterests.contains(t))
                                  .toList(),
                              onConnect: () => setState(() {
                                if (_connected.contains(person.id)) {
                                  _connected.remove(person.id);
                                } else {
                                  _connected.add(person.id);
                                }
                              }),
                            ),
                          );
                        },
                        childCount: people.length,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),
            _Footer(
              connectedCount: _connected.length,
              onStart: _handleStart,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Person Card
// ─────────────────────────────────────────────────────────────────────────────
class _Person {
  final String id;
  final String name;
  final String role;
  final String photoUrl;
  final List<String> tags;
  final int mutualConnections;

  const _Person({
    required this.id,
    required this.name,
    required this.role,
    required this.photoUrl,
    required this.tags,
    required this.mutualConnections,
  });
}

class _PersonCard extends StatelessWidget {
  final _Person person;
  final bool connected;
  final bool isMatch;
  final List<String> sharedInterests;
  final VoidCallback onConnect;

  static const _lavender = Color(0xFFA78BFA);

  const _PersonCard({
    required this.person,
    required this.connected,
    required this.isMatch,
    required this.sharedInterests,
    required this.onConnect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: connected
              ? _lavender.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(person.photoUrl),
                backgroundColor: const Color(0xFF2A2A2A),
              ),
              if (isMatch && sharedInterests.isNotEmpty)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: _lavender,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF1A1A1A), width: 2),
                    ),
                    child: const Icon(
                      Icons.star,
                      size: 8,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  person.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  person.role,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
                if (sharedInterests.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.interests_outlined,
                        size: 11,
                        color: _lavender.withValues(alpha: 0.8),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          sharedInterests.join(', '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: _lavender.withValues(alpha: 0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  const SizedBox(height: 6),
                  Text(
                    '${person.mutualConnections} conexiones en común',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.35),
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Connect button
          GestureDetector(
            onTap: onConnect,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: connected
                    ? _lavender
                    : _lavender.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: connected
                      ? _lavender
                      : _lavender.withValues(alpha: 0.35),
                ),
              ),
              child: Text(
                connected ? '✓' : 'Conectar',
                style: TextStyle(
                  color: connected ? Colors.white : _lavender,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
  final int connectedCount;
  final VoidCallback onStart;

  static const _lavender = Color(0xFFA78BFA);

  const _Footer({required this.connectedCount, required this.onStart});

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
              onPressed: onStart,
              style: ElevatedButton.styleFrom(
                backgroundColor: _lavender,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                connectedCount > 0
                    ? '¡Empezar! ($connectedCount conectadas)'
                    : '¡Empezar!',
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
            'Descubre más personas desde la sección Comunidad',
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
