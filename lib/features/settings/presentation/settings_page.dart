import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/theme/theme_provider.dart';

/// Settings page for theme and language configuration
/// 
/// This page allows users to change the theme mode (light/dark/system)
/// and switch between supported languages (English/Arabic).
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Theme Section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.theme,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _ThemeOption(
                  title: localizations.lightMode,
                  value: AppThemeMode.light,
                  currentValue: themeMode,
                  icon: Icons.light_mode,
                  onChanged: (mode) {
                    ref.read(themeModeProvider.notifier).setThemeMode(mode);
                  },
                ),
                const Divider(),
                _ThemeOption(
                  title: localizations.darkMode,
                  value: AppThemeMode.dark,
                  currentValue: themeMode,
                  icon: Icons.dark_mode,
                  onChanged: (mode) {
                    ref.read(themeModeProvider.notifier).setThemeMode(mode);
                  },
                ),
                const Divider(),
                _ThemeOption(
                  title: localizations.systemMode,
                  value: AppThemeMode.system,
                  currentValue: themeMode,
                  icon: Icons.brightness_auto,
                  onChanged: (mode) {
                    ref.read(themeModeProvider.notifier).setThemeMode(mode);
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Language Section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.language,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _LanguageOption(
                  title: localizations.english,
                  locale: AppLocales.english,
                  currentLocale: locale,
                  onChanged: (newLocale) {
                    ref.read(localeProvider.notifier).setLocale(newLocale);
                  },
                ),
                const Divider(),
                _LanguageOption(
                  title: localizations.arabic,
                  locale: AppLocales.arabic,
                  currentLocale: locale,
                  onChanged: (newLocale) {
                    ref.read(localeProvider.notifier).setLocale(newLocale);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Theme option widget
class _ThemeOption extends StatelessWidget {
  final String title;
  final AppThemeMode value;
  final AppThemeMode currentValue;
  final IconData icon;
  final ValueChanged<AppThemeMode> onChanged;

  const _ThemeOption({
    required this.title,
    required this.value,
    required this.currentValue,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == currentValue;
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title),
      trailing: isSelected
          ? Icon(Icons.check, color: theme.colorScheme.primary)
          : null,
      onTap: () => onChanged(value),
      selected: isSelected,
    );
  }
}

/// Language option widget
class _LanguageOption extends StatelessWidget {
  final String title;
  final Locale locale;
  final Locale currentLocale;
  final ValueChanged<Locale> onChanged;

  const _LanguageOption({
    required this.title,
    required this.locale,
    required this.currentLocale,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = locale == currentLocale;
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(Icons.language, color: theme.colorScheme.primary),
      title: Text(title),
      trailing: isSelected
          ? Icon(Icons.check, color: theme.colorScheme.primary)
          : null,
      onTap: () => onChanged(locale),
      selected: isSelected,
    );
  }
}

