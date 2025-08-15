import 'package:flutter/material.dart';
import '../../domain/entities/user_profile_entity.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final UserProfileEntity profile;

  const ProfileHeaderWidget({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Title only (no back button since this is a tab)
          Text(
            'Profile',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2E7D32),
                ),
          ),

          const SizedBox(height: 8),

          // Profile picture
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF2E7D32),
                width: 3,
              ),
            ),
            child: ClipOval(
              child: Image.network(
                profile.profileImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 4),

          // User name and profession
          Text(
            profile.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2E7D32),
                ),
          ),

          const SizedBox(height: 4),

          Text(
            profile.profession,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),

          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
