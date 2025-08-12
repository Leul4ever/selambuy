import 'package:flutter/material.dart';
import '../../../../core/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Theme Section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.palette,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Appearance',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.light_mode),
                              title: const Text('Light Mode'),
                              trailing: Radio<ThemeMode>(
                                value: ThemeMode.light,
                                groupValue: ThemeProvider.currentThemeMode,
                                onChanged: (ThemeMode? value) {
                                  if (value != null) {
                                    ThemeProvider.setCurrentThemeMode(value);
                                    // Force app rebuild by navigating to same route
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
                                  }
                                },
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.dark_mode),
                              title: const Text('Dark Mode'),
                              trailing: Radio<ThemeMode>(
                                value: ThemeMode.dark,
                                groupValue: ThemeProvider.currentThemeMode,
                                onChanged: (ThemeMode? value) {
                                  if (value != null) {
                                    ThemeProvider.setCurrentThemeMode(value);
                                    // Force app rebuild by navigating to same route
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
                                  }
                                },
                              ),
                            ),
                            ListTile(
                              leading:
                                  const Icon(Icons.settings_system_daydream),
                              title: const Text('System Default'),
                              trailing: Radio<ThemeMode>(
                                value: ThemeMode.system,
                                groupValue: ThemeProvider.currentThemeMode,
                                onChanged: (ThemeMode? value) {
                                  if (value != null) {
                                    ThemeProvider.setCurrentThemeMode(value);
                                    // Force app rebuild by navigating to same route
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Other Settings
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.notifications,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Notifications',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: const Text('Push Notifications'),
                          subtitle: const Text(
                              'Receive notifications about new products'),
                          value: true, // TODO: Implement notification settings
                          onChanged: (bool value) {
                            // TODO: Implement notification toggle
                          },
                        ),
                        SwitchListTile(
                          title: const Text('Email Notifications'),
                          subtitle: const Text('Receive updates via email'),
                          value: false, // TODO: Implement notification settings
                          onChanged: (bool value) {
                            // TODO: Implement notification toggle
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Account Section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_circle,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Account',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Profile'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // TODO: Navigate to profile page
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.security),
                          title: const Text('Privacy & Security'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // TODO: Navigate to privacy settings
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.help),
                          title: const Text('Help & Support'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // TODO: Navigate to help page
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.info),
                          title: const Text('About'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // TODO: Navigate to about page
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
