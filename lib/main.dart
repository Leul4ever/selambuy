import 'package:flutter/material.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'features/auth/presentation/pages/forgot_password_page.dart';
import 'features/home/presentation/pages/splash_page.dart';
import 'features/home/presentation/pages/onboarding_screen.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/home/presentation/pages/settings_page.dart';
import 'features/notifications/presentation/routes/notification_routes.dart';
import 'core/service_locator.dart';
import 'core/theme_provider.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YeneGebiya',
      theme: ThemeProvider.lightTheme,
      darkTheme: ThemeProvider.darkTheme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Delegate notification routes
        if (settings.name?.startsWith('/notifications') ?? false) {
          return NotificationRoutes.onGenerateRoute(settings);
        }
        // Default routes
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashPage());
          case '/onboarding':
            return MaterialPageRoute(
                builder: (_) => const OnboardingScreen());
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomePage());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/signup':
            return MaterialPageRoute(builder: (_) => const SignupPage());
          case '/forgot-password':
            return MaterialPageRoute(
                builder: (_) => const ForgotPasswordPage());
          case '/settings':
            return MaterialPageRoute(
                builder: (_) => const SettingsPage());
          default:
            return MaterialPageRoute(
              builder: (_) => const Scaffold(
                body: Center(child: Text('Route not found')),
              ),
            );
        }
      },
    );
  }
}
