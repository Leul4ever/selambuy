import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark, system }

class ThemeCubit extends Cubit<AppThemeMode> {
  static const String _themeKey = 'theme_mode';
  
  ThemeCubit() : super(AppThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themeKey) ?? 0;
      emit(AppThemeMode.values[themeIndex]);
    } catch (e) {
      emit(AppThemeMode.light);
    }
  }

  Future<void> setTheme(AppThemeMode themeMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, themeMode.index);
      emit(themeMode);
    } catch (e) {
      // If saving fails, still update the UI
      emit(themeMode);
    }
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
