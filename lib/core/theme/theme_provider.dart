import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';

/// Theme mode enum
enum AppThemeMode {
  light,
  dark,
  system,
}

/// Provider for theme mode state
/// 
/// This provider manages the application's theme mode and persists
/// the user's preference using SharedPreferences.
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, AppThemeMode>(
  (ref) => ThemeModeNotifier(),
);

/// Notifier for theme mode state management
class ThemeModeNotifier extends StateNotifier<AppThemeMode> {
  static const String _themeKey = 'theme_mode';

  ThemeModeNotifier() : super(AppThemeMode.system) {
    _loadTheme();
  }

  /// Load saved theme preference
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getString(_themeKey);
      if (savedTheme != null) {
        state = AppThemeMode.values.firstWhere(
          (mode) => mode.name == savedTheme,
          orElse: () => AppThemeMode.system,
        );
      }
    } catch (e) {
      // If loading fails, use system default
      state = AppThemeMode.system;
    }
  }

  /// Set theme mode and persist preference
  Future<void> setThemeMode(AppThemeMode mode) async {
    state = mode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, mode.name);
    } catch (e) {
      // If saving fails, continue with the theme change
    }
  }

  /// Toggle between light and dark themes
  Future<void> toggleTheme() async {
    final newMode = state == AppThemeMode.dark
        ? AppThemeMode.light
        : AppThemeMode.dark;
    await setThemeMode(newMode);
  }
}

/// Provider for current theme data based on theme mode
final themeProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  
  // For system mode, we'd check the system brightness
  // For simplicity, we'll use light as default for system
  // In a real app, you'd use MediaQuery.platformBrightnessOf(context)
  switch (themeMode) {
    case AppThemeMode.light:
      return AppTheme.lightTheme;
    case AppThemeMode.dark:
      return AppTheme.darkTheme;
    case AppThemeMode.system:
      return AppTheme.lightTheme; // Default to light for system
  }
});

/// Provider for current brightness
final brightnessProvider = Provider<Brightness>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  switch (themeMode) {
    case AppThemeMode.light:
      return Brightness.light;
    case AppThemeMode.dark:
      return Brightness.dark;
    case AppThemeMode.system:
      return Brightness.light; // Default to light for system
  }
});

