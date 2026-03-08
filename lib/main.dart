import 'package:flutter/material.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/signup_screen.dart';
import 'features/auth/screens/interests_screen.dart';
import 'features/community/screens/startup_lab_screen.dart';
import 'features/discover/discover.dart';
import 'features/home/screens/home_screen.dart';
import 'widgets/bottom_nav_bar.dart';

void main() {
  runApp(const LotusVestApp());
}

class LotusVestApp extends StatelessWidget {
  const LotusVestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LotusVest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFA78BFA),
          surface: Color(0xFF1E1E1E),
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignupScreen(),
        '/onboarding': (_) => const InterestsScreen(),
        '/home': (_) => const MainShell(),
      },
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  // Placeholder pages — replace each with real screen widgets
  static const List<Widget> _pages = [
    HomeScreen(),
    StartupLabScreen(),
    DiscoverScreen(),
    _PlaceholderPage(label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: _pages[_currentIndex],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          onPressed: () {
            // TODO: open Create screen
          },
          backgroundColor: const Color(0xFFA78BFA),
          shape: const CircleBorder(),
          elevation: 6,
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String label;
  const _PlaceholderPage({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFA78BFA),
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B4EFF),
        foregroundColor: Colors.white,
        title: const Text('LotusVest'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(child: Text('Pantalla de Inicio')),
    );
  }
}

class _DiscoverScreen extends StatelessWidget {
  const _DiscoverScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B4EFF),
        foregroundColor: Colors.white,
        title: const Text('Discover'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: const Center(child: Text('Pantalla de Discover')),
    );
  }
}

class _CreateScreen extends StatelessWidget {
  const _CreateScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B4EFF),
        foregroundColor: Colors.white,
        title: const Text('Create'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Crear nuevo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildCreateOption(
              context,
              icon: Icons.campaign,
              title: 'Publicar avance',
              description: 'Comparte el progreso de tu startup',
              color: const Color(0xFF6B4EFF),
            ),
            const SizedBox(height: 16),
            _buildCreateOption(
              context,
              icon: Icons.emoji_events,
              title: 'Compartir logro',
              description: 'Celebra tus éxitos con la comunidad',
              color: Colors.amber[700]!,
            ),
            const SizedBox(height: 16),
            _buildCreateOption(
              context,
              icon: Icons.forum,
              title: 'Iniciar discusión',
              description: 'Crea un hilo en los foros',
              color: Colors.teal,
            ),
            const SizedBox(height: 16),
            _buildCreateOption(
              context,
              icon: Icons.handshake,
              title: 'Ofrecer apoyo',
              description: 'Comparte tu expertise o mentoría',
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey[400]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B4EFF),
        foregroundColor: Colors.white,
        title: const Text('Mi Perfil'),
      ),
      body: const Center(child: Text('Pantalla de Perfil')),
    );
  }
}

class CarouselItem {
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  CarouselItem({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });
}
