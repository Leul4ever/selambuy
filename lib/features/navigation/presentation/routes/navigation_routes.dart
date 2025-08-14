import 'package:flutter/material.dart';
import '../pages/main_navigation_page.dart';

class NavigationRoutes {
  static const String mainNavigation = '/main-navigation';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainNavigation:
        return MaterialPageRoute(
          builder: (_) => const MainNavigationPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Navigation route not found')),
          ),
        );
    }
  }
}
