import '../models/user_profile.dart';
import '../../community/models/models.dart';
import '../../community/services/community_service.dart';

class ProfileService {
  static UserProfile getMockCurrentUser() {
    return const UserProfile(
      id: 'user_maria',
      name: 'María González',
      subheader: 'Founder & CEO · FinaHer · Fintech 🚀',
      bio:
          'Emprendedora apasionada por democratizar el acceso al crédito para mujeres en LATAM. '
          'Construyendo FinaHer desde CDMX. Ex-Bancomer. Forbes 30 Under 30 MX \'24.',
      photoUrl:
          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400',
      coverUrl: 'https://images.unsplash.com/photo-1557804506-669a67965ba0?w=800',
      socialLinks: [
        SocialLink(
          platform: 'github',
          url: 'https://github.com/mariagonzalez',
          handle: 'mariagonzalez',
        ),
        SocialLink(
          platform: 'linkedin',
          url: 'https://linkedin.com/in/mariagonzalez',
          handle: 'mariagonzalez',
        ),
      ],
      startupIds: ['startup1'],
      followersCount: 1240,
      followingCount: 328,
      connectionsCount: 87,
      isFollowedByCurrentUser: false,
      isConnectedToCurrentUser: false,
    );
  }

  static UserProfile getMockOtherUser() {
    return const UserProfile(
      id: 'user_ana',
      name: 'Ana Rodríguez',
      subheader: 'Co-founder · MindFlow · HealthTech 💜',
      bio:
          'Psicóloga convertida en tech founder. Creo en que el bienestar mental es el motor de cualquier '
          'startup exitoso. Construyendo MindFlow para emprendedoras como tú.',
      photoUrl: 'https://i.pravatar.cc/400?img=5',
      coverUrl: null,
      socialLinks: [
        SocialLink(
          platform: 'linkedin',
          url: 'https://linkedin.com/in/anarodriguez',
          handle: 'anarodriguez',
        ),
      ],
      startupIds: ['startup2'],
      followersCount: 892,
      followingCount: 214,
      connectionsCount: 55,
      isFollowedByCurrentUser: true,
      isConnectedToCurrentUser: false,
    );
  }

  static List<Post> getPostsForUser(String userId) {
    return CommunityService.getMockAllPosts()
        .where((p) => p.authorName.contains('María') && userId == 'user_maria' ||
            p.authorName.contains('Ana') && userId == 'user_ana')
        .toList();
  }

  static List<Startup> getStartupsForUser(List<String> startupIds) {
    return CommunityService.getMockStartups()
        .where((s) => startupIds.contains(s.id))
        .toList();
  }
}
