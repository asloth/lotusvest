import 'package:flutter/material.dart';
import '../models/pitch_project.dart';
import '../widgets/pitch_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color _primaryColor = Color(0xFFA78BFA);
  static const Color _backgroundColor = Color(0xFF121212);
  static const Color _surfaceColor = Color(0xFF1E1E1E);

  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'AI', 'Fintech', 'Health', 'EdTech'];

  final List<PitchProject> _allProjects = [
    PitchProject(
      id: '1',
      name: 'MindFlow AI',
      founderName: 'Ana Rodríguez',
      founderPhotoUrl: 'https://i.pravatar.cc/150?img=5',
      thumbnailUrl: 'https://picsum.photos/seed/mindflow/600/400',
      description:
          'AI-powered mental wellness platform tailored for women entrepreneurs. Personalized coaching, mood tracking, and burnout prevention.',
      category: 'Health',
      categoryColor: const Color(0xFFEC4899),
      techStack: ['Python', 'TensorFlow', 'AWS'],
      fundingGoal: 50000,
      currentFunding: 32500,
      backersCount: 214,
      daysLeft: 18,
    ),
    PitchProject(
      id: '2',
      name: 'FinaHer',
      founderName: 'María González',
      founderPhotoUrl: 'https://i.pravatar.cc/150?img=1',
      thumbnailUrl: 'https://picsum.photos/seed/finaher/600/400',
      description:
          'Micro-lending platform designed for women-led startups in Latin America. Zero collateral, fast approval, community-backed.',
      category: 'Fintech',
      categoryColor: const Color(0xFF10B981),
      techStack: ['Flutter', 'Firebase', 'Stripe'],
      fundingGoal: 80000,
      currentFunding: 54000,
      backersCount: 389,
      daysLeft: 12,
    ),
    PitchProject(
      id: '3',
      name: 'EduSpark',
      founderName: 'Laura Martínez',
      founderPhotoUrl: 'https://i.pravatar.cc/150?img=9',
      thumbnailUrl: 'https://picsum.photos/seed/eduspark/600/400',
      description:
          'Adaptive learning platform using ML to personalize educational paths for underprivileged students across Latin America.',
      category: 'EdTech',
      categoryColor: const Color(0xFFF59E0B),
      techStack: ['React Native', 'Node.js', 'ML'],
      fundingGoal: 35000,
      currentFunding: 12250,
      backersCount: 97,
      daysLeft: 25,
    ),
    PitchProject(
      id: '4',
      name: 'NovaMind',
      founderName: 'Sofía Herrera',
      founderPhotoUrl: 'https://i.pravatar.cc/150?img=16',
      thumbnailUrl: 'https://picsum.photos/seed/novamind/600/400',
      description:
          'Generative AI assistant for small business owners. Automates invoicing, inventory management, and customer communication.',
      category: 'AI',
      categoryColor: const Color(0xFF8B5CF6),
      techStack: ['Python', 'OpenAI', 'FastAPI', 'Docker'],
      fundingGoal: 60000,
      currentFunding: 47800,
      backersCount: 312,
      daysLeft: 7,
    ),
    PitchProject(
      id: '5',
      name: 'GreenTrace',
      founderName: 'Camila Vega',
      founderPhotoUrl: 'https://i.pravatar.cc/150?img=21',
      thumbnailUrl: 'https://picsum.photos/seed/greentrace/600/400',
      description:
          'AI-driven carbon footprint tracker for SMEs. Real-time supply chain analysis with actionable sustainability insights.',
      category: 'AI',
      categoryColor: const Color(0xFF8B5CF6),
      techStack: ['Python', 'TensorFlow', 'GCP', 'GraphQL'],
      fundingGoal: 45000,
      currentFunding: 18000,
      backersCount: 143,
      daysLeft: 30,
    ),
    PitchProject(
      id: '6',
      name: 'PayHer',
      founderName: 'Valentina Cruz',
      founderPhotoUrl: 'https://i.pravatar.cc/150?img=32',
      thumbnailUrl: 'https://picsum.photos/seed/payher/600/400',
      description:
          'Wage-on-demand fintech app targeting gig economy workers. Access earned wages instantly without waiting for payday.',
      category: 'Fintech',
      categoryColor: const Color(0xFF10B981),
      techStack: ['Flutter', 'Node.js', 'PostgreSQL'],
      fundingGoal: 70000,
      currentFunding: 61000,
      backersCount: 501,
      daysLeft: 5,
    ),
  ];

  List<PitchProject> get _filteredProjects {
    if (_selectedCategory == 'All') return _allProjects;
    return _allProjects.where((p) => p.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildTopBar()),
            SliverToBoxAdapter(child: _buildSearchBar()),
            SliverToBoxAdapter(child: _buildCategoryChips()),
            SliverToBoxAdapter(child: _buildPitchWallHeader()),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => PitchCard(project: _filteredProjects[index]),
                childCount: _filteredProjects.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 8),
      child: Row(
        children: [
          // App name
          const Text(
            'LotusVest',
            style: TextStyle(
              color: _primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          // Notification bell
          IconButton(
            onPressed: () {},
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_outlined, color: Colors.white70, size: 26),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: _primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Profile avatar
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _primaryColor, width: 2),
              ),
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=47'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search projects, founders...',
          hintStyle: const TextStyle(color: Colors.white38),
          prefixIcon: const Icon(Icons.search, color: Colors.white38),
          suffixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.tune, color: _primaryColor, size: 20),
          ),
          filled: true,
          fillColor: _surfaceColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;
          return FilterChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (_) => setState(() => _selectedCategory = category),
            backgroundColor: _surfaceColor,
            selectedColor: _primaryColor,
            checkmarkColor: Colors.white,
            showCheckmark: false,
            side: BorderSide(
              color: isSelected ? _primaryColor : Colors.white24,
            ),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.white60,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          );
        },
      ),
    );
  }

  Widget _buildPitchWallHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
      child: Row(
        children: [
          const Text(
            'The Pitch Wall',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${_filteredProjects.length} projects',
              style: const TextStyle(
                color: _primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
