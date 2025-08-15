import 'package:flutter/material.dart';
import '../../data/datasources/profile_local_datasource.dart';
import '../../data/models/profile_menu_item_model.dart';

class ProfileMenuListWidget extends StatelessWidget {
  const ProfileMenuListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          FutureBuilder<List<ProfileMenuItemModel>>(
            future: ProfileLocalDataSourceImpl().getProfileMenuItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError || !snapshot.hasData) {
                return const Center(child: Text('Failed to load menu items'));
              }

              final menuItems = snapshot.data!;

              return Column(
                children: menuItems
                    .map((item) => _buildMenuItem(context, item))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, ProfileMenuItemModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF2E7D32).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getIconForMenuItem(item.id),
            color: const Color(0xFF2E7D32),
            size: 24,
          ),
        ),
        title: Text(
          item.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2E7D32),
              ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFF2E7D32),
          size: 20,
        ),
        onTap: item.isEnabled ? () => _onMenuItemTap(context, item) : null,
      ),
    );
  }

  IconData _getIconForMenuItem(String itemId) {
    switch (itemId) {
      case 'edit_profile':
        return Icons.person;
      case 'shipping_address':
        return Icons.location_on;
      default:
        return Icons.info;
    }
  }

  void _onMenuItemTap(BuildContext context, ProfileMenuItemModel item) {
    // TODO: Implement navigation to respective pages
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.title} functionality coming soon!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
