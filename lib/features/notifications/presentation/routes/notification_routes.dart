import 'package:flutter/material.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../pages/notification_screen.dart';

class NotificationRoutes {
  static const String notifications = '/notifications';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case notifications:
        bool isLoggedIn = NotificationScreen.isLoggedIn;
        return MaterialPageRoute(
          builder: (_) =>
              isLoggedIn ? const NotificationScreen() : const LoginPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
