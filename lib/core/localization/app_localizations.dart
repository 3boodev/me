import 'package:flutter/material.dart';

/// Supported locales in the application
class AppLocales {
  static const Locale english = Locale('en', 'US');
  static const Locale arabic = Locale('ar', 'SA');

  static const List<Locale> supportedLocales = [english, arabic];
}

/// Localization delegate for the application
/// 
/// This class provides localized strings for the application.
/// To add a new language:
/// 1. Add the locale to AppLocales.supportedLocales
/// 2. Add translation strings in the _localizedValues map
/// 3. Add the language name in getLanguageName method
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Translation keys
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'Abdullah Alamary',
      'name': 'Name',
      'job_title': 'Job Title',
      'email': 'Email',
      'phone': 'Phone',
      'whatsapp': 'WhatsApp',
      'website': 'Website',
      'share': 'Share',
      'settings': 'Settings',
      'theme': 'Theme',
      'language': 'Language',
      'light_mode': 'Light Mode',
      'dark_mode': 'Dark Mode',
      'system_mode': 'System Mode',
      'english': 'English',
      'arabic': 'Arabic',
      'contact_me': 'Contact Me',
      'social_links': 'Social Links',
      'scan_qr': 'Scan QR Code',
    },
    'ar': {
      'app_title': 'Abdullah Alamary',
      'name': 'الاسم',
      'job_title': 'المسمى الوظيفي',
      'email': 'البريد الإلكتروني',
      'phone': 'الهاتف',
      'whatsapp': 'واتساب',
      'website': 'الموقع الإلكتروني',
      'share': 'مشاركة',
      'settings': 'الإعدادات',
      'theme': 'المظهر',
      'language': 'اللغة',
      'light_mode': 'الوضع الفاتح',
      'dark_mode': 'الوضع الداكن',
      'system_mode': 'وضع النظام',
      'english': 'الإنجليزية',
      'arabic': 'العربية',
      'contact_me': 'اتصل بي',
      'social_links': 'روابط التواصل',
      'scan_qr': 'امسح رمز QR',
    },
  };

  String _getLocalizedValue(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Getters for localized strings
  String get appTitle => _getLocalizedValue('app_title');
  String get name => _getLocalizedValue('name');
  String get jobTitle => _getLocalizedValue('job_title');
  String get email => _getLocalizedValue('email');
  String get phone => _getLocalizedValue('phone');
  String get whatsapp => _getLocalizedValue('whatsapp');
  String get website => _getLocalizedValue('website');
  String get share => _getLocalizedValue('share');
  String get settings => _getLocalizedValue('settings');
  String get theme => _getLocalizedValue('theme');
  String get language => _getLocalizedValue('language');
  String get lightMode => _getLocalizedValue('light_mode');
  String get darkMode => _getLocalizedValue('dark_mode');
  String get systemMode => _getLocalizedValue('system_mode');
  String get english => _getLocalizedValue('english');
  String get arabic => _getLocalizedValue('arabic');
  String get contactMe => _getLocalizedValue('contact_me');
  String get socialLinks => _getLocalizedValue('social_links');
  String get scanQr => _getLocalizedValue('scan_qr');

  /// Get display name for a locale
  static String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'ar':
        return 'العربية';
      default:
        return locale.languageCode;
    }
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocales.supportedLocales
        .any((l) => l.languageCode == locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

