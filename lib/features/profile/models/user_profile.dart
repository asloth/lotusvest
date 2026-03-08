class SocialLink {
  final String platform; // 'github' | 'linkedin'
  final String url;
  final String handle;

  const SocialLink({
    required this.platform,
    required this.url,
    required this.handle,
  });
}

class UserProfile {
  final String id;
  final String name;
  final String subheader; // role / tagline
  final String bio;
  final String photoUrl;
  final String? coverUrl;
  final List<SocialLink> socialLinks;
  final List<String> startupIds; // IDs of registered startups
  final int followersCount;
  final int followingCount;
  final int connectionsCount;
  final bool isFollowedByCurrentUser;
  final bool isConnectedToCurrentUser;

  const UserProfile({
    required this.id,
    required this.name,
    required this.subheader,
    required this.bio,
    required this.photoUrl,
    this.coverUrl,
    required this.socialLinks,
    required this.startupIds,
    required this.followersCount,
    required this.followingCount,
    required this.connectionsCount,
    this.isFollowedByCurrentUser = false,
    this.isConnectedToCurrentUser = false,
  });
}
