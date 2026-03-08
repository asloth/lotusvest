import '../models/models.dart';

class CommunityService {
  // Mock data for demonstration

  static List<Post> getMockPostsByStartup(String startupId) {
    return [
      Post(
        id: '1',
        startupId: 'startup1',
        authorName: 'María González',
        authorPhotoUrl:
            'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200',
        content:
            '¡Acabamos de cerrar nuestra primera ronda de pruebas beta! 🚀 Más de 100 usuarios probando nuestra plataforma de microcréditos para emprendedoras. Los resultados son increíbles.',
        imageUrls: [],
        type: PostType.milestone,
        likesCount: 45,
        commentsCount: 12,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Post(
        id: '2',
        startupId: 'startup1',
        authorName: 'María González',
        authorPhotoUrl:
            'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200',
        content:
            'Nuestro equipo trabajando en las nuevas funciones de IA para detección de fraude. ¡El futuro de Fintech es ahora!',
        imageUrls: ['https://picsum.photos/400/300'],
        type: PostType.teamPhoto,
        likesCount: 32,
        commentsCount: 8,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  static List<Post> getMockAllPosts() {
    return [
      Post(
        id: '1',
        startupId: 'startup1',
        authorName: 'María González',
        authorPhotoUrl:
            'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200',
        content:
            '¡Acabamos de cerrar nuestra primera ronda de pruebas beta! 🚀 Más de 100 usuarios probando nuestra plataforma de microcréditos para emprendedoras. Los resultados son increíbles.',
        imageUrls: [],
        type: PostType.milestone,
        likesCount: 45,
        commentsCount: 12,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Post(
        id: '2',
        startupId: 'startup1',
        authorName: 'María González',
        authorPhotoUrl:
            'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200',
        content:
            'Nuestro equipo trabajando en las nuevas funciones de IA para detección de fraude. ¡El futuro de Fintech es ahora!',
        imageUrls: ['https://picsum.photos/400/300'],
        type: PostType.teamPhoto,
        likesCount: 32,
        commentsCount: 8,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Post(
        id: '3',
        startupId: 'startup2',
        authorName: 'Ana Rodríguez',
        authorPhotoUrl: 'https://i.pravatar.cc/150?img=5',
        content:
            'Preview de nuestra app de salud mental para mujeres emprendedoras. El bienestar es productividad. 💜',
        imageUrls: ['https://picsum.photos/400/250'],
        type: PostType.productPreview,
        likesCount: 67,
        commentsCount: 23,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Post(
        id: '4',
        startupId: 'startup3',
        authorName: 'Laura Martínez',
        authorPhotoUrl: 'https://i.pravatar.cc/150?img=9',
        content:
            'Actualización semanal: Integramos machine learning para personalizar recomendaciones educativas. Cada estudiante es único.',
        imageUrls: [],
        type: PostType.update,
        likesCount: 28,
        commentsCount: 5,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }

  static List<Forum> getMockForums() {
    return [
      Forum(
        id: '1',
        title: 'Tecnología',
        category: ForumCategory.technology,
        description:
            'Discusiones sobre stack tecnológico, arquitectura y desarrollo',
        threadsCount: 45,
        membersCount: 234,
        lastActivity: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      Forum(
        id: '2',
        title: 'Estrategia de Mercado',
        category: ForumCategory.marketStrategy,
        description:
            'Comparte y aprende sobre go-to-market, pricing y growth hacking',
        threadsCount: 32,
        membersCount: 189,
        lastActivity: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      Forum(
        id: '3',
        title: 'Feedback del Producto',
        category: ForumCategory.productFeedback,
        description:
            'Recibe feedback constructivo de la comunidad sobre tu producto',
        threadsCount: 67,
        membersCount: 312,
        lastActivity: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
    ];
  }

  static List<ForumThread> getMockThreads(String forumId) {
    return [
      ForumThread(
        id: '1',
        forumId: forumId,
        title: '¿Cuál es el mejor stack para una fintech en 2024?',
        authorName: 'María González',
        authorPhotoUrl:
            'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200',
        preview:
            'Estoy evaluando entre Flutter + Firebase vs React Native + AWS...',
        repliesCount: 23,
        viewsCount: 156,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        lastReplyAt: DateTime.now().subtract(const Duration(hours: 3)),
        isPinned: true,
      ),
      ForumThread(
        id: '2',
        forumId: forumId,
        title: 'Implementando pagos con Stripe en Latam',
        authorName: 'Ana Rodríguez',
        authorPhotoUrl: 'https://i.pravatar.cc/150?img=5',
        preview: 'Quiero compartir mi experiencia integrando Stripe...',
        repliesCount: 15,
        viewsCount: 89,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        lastReplyAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  static List<AllyOffer> getMockAllyOffers() {
    return [
      AllyOffer(
        id: '1',
        allyId: 'ally1',
        allyName: 'Carlos Mendoza',
        allyPhotoUrl: 'https://i.pravatar.cc/150?img=11',
        type: AllyOfferType.mentorship,
        title: 'Mentoría en Fintech & Regulación',
        description:
            '15 años de experiencia en banca digital. Disponible 2h/semana para mentorías sobre compliance y estrategia.',
        isAvailable: true,
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
      AllyOffer(
        id: '2',
        allyId: 'ally2',
        allyName: 'Patricia Vega',
        allyPhotoUrl: 'https://i.pravatar.cc/150?img=20',
        type: AllyOfferType.networking,
        title: 'Conexiones en Silicon Valley',
        description:
            'Puedo conectarte con VCs y founders en el ecosistema tech de SF/Bay Area.',
        isAvailable: true,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      AllyOffer(
        id: '3',
        allyId: 'ally3',
        allyName: 'Roberto Silva',
        allyPhotoUrl: 'https://i.pravatar.cc/150?img=12',
        type: AllyOfferType.expertise,
        title: 'Consultoría UX/UI',
        description:
            'Director de diseño en empresa unicornio. Ofrezco revisiones de producto y feedback de diseño.',
        isAvailable: true,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      AllyOffer(
        id: '4',
        allyId: 'ally4',
        allyName: 'Elena Torres',
        allyPhotoUrl: 'https://i.pravatar.cc/150?img=25',
        type: AllyOfferType.funding,
        title: 'Angel Investment - Pre-seed',
        description:
            'Inversionista ángel enfocada en startups lideradas por mujeres. Tickets de \$10k-\$50k.',
        isAvailable: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  static List<Startup> getMockStartups() {
    return [
      Startup(
        id: 'startup1',
        name: 'FinaHer',
        description:
            'Plataforma de microcréditos diseñada para emprendedoras en Latinoamérica',
        founderName: 'María González',
        founderPhotoUrl:
            'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200',
        logoUrl: 'https://picsum.photos/100',
        industry: Industry.fintech,
        stage: StartupStage.preSeed,
        technologies: ['Flutter', 'Firebase', 'IA'],
        fundingGoal: 50000,
        currentFunding: 32500,
        membersCount: 156,
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
      ),
      Startup(
        id: 'startup2',
        name: 'MindFlow',
        description:
            'App de bienestar mental para mujeres en el ecosistema emprendedor',
        founderName: 'Ana Rodríguez',
        founderPhotoUrl: 'https://i.pravatar.cc/150?img=5',
        logoUrl: 'https://picsum.photos/101',
        industry: Industry.healthtech,
        stage: StartupStage.ideation,
        technologies: ['React Native', 'Node.js', 'ML'],
        fundingGoal: 25000,
        currentFunding: 8750,
        membersCount: 89,
        createdAt: DateTime.now().subtract(const Duration(days: 45)),
      ),
    ];
  }
}
