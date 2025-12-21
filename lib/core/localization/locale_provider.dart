import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_localizations.dart';

/// Provider for locale state management
/// 
/// This provider manages the application's locale and persists
/// the user's preference using SharedPreferences.
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);

/// Notifier for locale state management
class LocaleNotifier extends StateNotifier<Locale> {
  static const String _localeKey = 'app_locale';

  LocaleNotifier() : super(AppLocales.english) {
    _loadLocale();
  }

  /// Load saved locale preference
  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLocale = prefs.getString(_localeKey);
      if (savedLocale != null) {
        final locale = Locale(savedLocale);
        if (AppLocales.supportedLocales.contains(locale)) {
          state = locale;
        }
      }
    } catch (e) {
      // If loading fails, use default locale
      state = AppLocales.english;
    }
  }

  /// Set locale and persist preference
  Future<void> setLocale(Locale locale) async {
    if (AppLocales.supportedLocales.contains(locale)) {
      state = locale;
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_localeKey, locale.languageCode);
      } catch (e) {
        // If saving fails, continue with the locale change
      }
    }
  }

  /// Toggle between English and Arabic
  Future<void> toggleLocale() async {
    final newLocale = state == AppLocales.arabic
        ? AppLocales.english
        : AppLocales.arabic;
    await setLocale(newLocale);
  }

  /// Check if current locale is RTL
  bool get isRTL => state == AppLocales.arabic;
}

