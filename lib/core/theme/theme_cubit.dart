import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AppThemeMode { light, dark, system }

class ThemeCubit extends Cubit<AppThemeMode> {
  static const String _themeKey = 'theme_mode';
  
  ThemeCubit() : super(AppThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    // For now, just use default theme to avoid storage issues
    emit(AppThemeMode.light);
  }

  Future<void> setTheme(AppThemeMode themeMode) async {
    // For now, just update the UI without persistence
    emit(themeMode);
  }

  ThemeMode getMaterialThemeMode(BuildContext context) {
    switch (state) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return MediaQuery.of(context).platformBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light;
    }
  }

  bool get isDarkMode => state == AppThemeMode.dark;
  bool get isLightMode => state == AppThemeMode.light;
  bool get isSystemMode => state == AppThemeMode.system;
}
