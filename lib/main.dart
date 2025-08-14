import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'features/auth/presentation/pages/forgot_password_page.dart';
import 'features/home/presentation/pages/splash_page.dart';
import 'features/home/presentation/pages/onboarding_screen.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/settings/presentation/screens/settings_screen.dart';
import 'features/notifications/presentation/routes/notification_routes.dart';
import 'features/navigation/presentation/routes/navigation_routes.dart';
import 'features/navigation/presentation/bloc/navigation_bloc.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'core/service_locator.dart';
import 'core/theme/app_themes.dart';
import 'core/theme/theme_cubit.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ThemeCubit>()),
        BlocProvider(create: (context) => sl<NavigationBloc>()),
        BlocProvider(create: (context) => sl<CartBloc>()),
      ],
      child: const _AppContent(),
    );
  }
}

class _AppContent extends StatelessWidget {
  const _AppContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, AppThemeMode>(
      builder: (context, appThemeMode) {
        final themeMode = context.read<ThemeCubit>().getMaterialThemeMode(context);
        return MaterialApp(
          title: 'YeneGebiya',
          themeMode: themeMode,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            // Delegate notification routes
            if (settings.name?.startsWith('/notifications') ?? false) {
              return NotificationRoutes.onGenerateRoute(settings);
            }
            // Delegate navigation routes
            if (settings.name?.startsWith('/main-navigation') ?? false) {
              return NavigationRoutes.onGenerateRoute(settings);
            }
            // Default routes
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (_) => const SplashPage());
              case '/onboarding':
                return MaterialPageRoute(builder: (_) => const OnboardingScreen());
              case '/home':
                return MaterialPageRoute(builder: (_) => const HomePage());
              case '/main-navigation':
                return NavigationRoutes.onGenerateRoute(settings);
              case '/login':
                return MaterialPageRoute(builder: (_) => const LoginScreen());
              case '/signup':
                return MaterialPageRoute(builder: (_) => const SignupPage());
              case '/forgot-password':
                return MaterialPageRoute(
                    builder: (_) => const ForgotPasswordPage());
              case '/settings':
                return MaterialPageRoute(builder: (_) => const SettingsScreen());
              default:
                return MaterialPageRoute(
                  builder: (_) => const Scaffold(
                    body: Center(child: Text('Route not found')),
                  ),
                );
            }
          },
        );
      },
    );
  }
}
