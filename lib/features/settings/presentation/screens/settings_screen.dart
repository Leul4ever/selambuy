import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        foregroundColor: colorScheme.onSurface,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Theme Section
            _buildSectionHeader(context, 'Appearance'),
            _buildThemeSection(context),
            
            const SizedBox(height: 24),
            
            // Account Section
            _buildSectionHeader(context, 'Account'),
            _buildSettingTile(
              context,
              icon: Icons.person_outline,
              title: 'Profile',
              subtitle: 'Manage your account information',
              onTap: () {
                // TODO: Navigate to profile
              },
            ),
            _buildSettingTile(
              context,
              icon: Icons.security,
              title: 'Privacy & Security',
              subtitle: 'Control your privacy settings',
              onTap: () {
                // TODO: Navigate to privacy settings
              },
            ),
            
            const SizedBox(height: 24),
            
            // Preferences Section
            _buildSectionHeader(context, 'Preferences'),
            _buildSettingTile(
              context,
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              subtitle: 'Manage notification preferences',
              onTap: () {
                // TODO: Navigate to notification settings
              },
            ),
            _buildSettingTile(
              context,
              icon: Icons.language,
              title: 'Language',
              subtitle: 'English (US)',
              onTap: () {
                // TODO: Show language picker
              },
            ),
            
            const SizedBox(height: 24),
            
            // Support Section
            _buildSectionHeader(context, 'Support'),
            _buildSettingTile(
              context,
              icon: Icons.help_outline,
              title: 'Help Center',
              subtitle: 'Get help and support',
              onTap: () {
                // TODO: Navigate to help center
              },
            ),
            _buildSettingTile(
              context,
              icon: Icons.feedback_outlined,
              title: 'Send Feedback',
              subtitle: 'Help us improve the app',
              onTap: () {
                // TODO: Show feedback dialog
              },
            ),
            
            const SizedBox(height: 24),
            
            // About Section
            _buildSectionHeader(context, 'About'),
            _buildSettingTile(
              context,
              icon: Icons.info_outline,
              title: 'App Version',
              subtitle: '1.0.0',
              onTap: null,
            ),
            _buildSettingTile(
              context,
              icon: Icons.description_outlined,
              title: 'Terms of Service',
              subtitle: 'Read our terms and conditions',
              onTap: () {
                // TODO: Show terms of service
              },
            ),
            _buildSettingTile(
              context,
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              subtitle: 'Read our privacy policy',
              onTap: () {
                // TODO: Show privacy policy
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.palette_outlined,
                  color: colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Theme',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<ThemeCubit, AppThemeMode>(
              builder: (context, currentTheme) {
                return Column(
                  children: [
                    _buildThemeOption(
                      context,
                      title: 'Light',
                      subtitle: 'Use light theme',
                      icon: Icons.light_mode,
                      isSelected: currentTheme == AppThemeMode.light,
                      onTap: () => context.read<ThemeCubit>().setTheme(AppThemeMode.light),
                    ),
                    _buildThemeOption(
                      context,
                      title: 'Dark',
                      subtitle: 'Use dark theme',
                      icon: Icons.dark_mode,
                      isSelected: currentTheme == AppThemeMode.dark,
                      onTap: () => context.read<ThemeCubit>().setTheme(AppThemeMode.dark),
                    ),
                    _buildThemeOption(
                      context,
                      title: 'System',
                      subtitle: 'Follow system theme',
                      icon: Icons.settings_system_daydream,
                      isSelected: currentTheme == AppThemeMode.system,
                      onTap: () => context.read<ThemeCubit>().setTheme(AppThemeMode.system),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: colorScheme.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: colorScheme.primary,
          size: 24,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: onTap != null
            ? Icon(
                Icons.chevron_right,
                color: colorScheme.onSurfaceVariant,
                size: 20,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
