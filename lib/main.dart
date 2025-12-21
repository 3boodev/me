import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/locale_provider.dart';
import 'core/routing/app_router.dart';
import 'core/theme/theme_provider.dart';

/// Main entry point of the application
/// 
/// This sets up:
/// - Riverpod for state management
/// - go_router for navigation
/// - Localization (English/Arabic with RTL support)
/// - Theme system (light/dark with persistence)
void main() {
  runApp(
    const ProviderScope(
      child: BusinessCardApp(),
    ),
  );
}

/// Root application widget
/// 
/// This widget configures the MaterialApp with:
/// - Theme from Riverpod provider
/// - Localization delegates
/// - Router from go_router
/// - RTL support for Arabic
class BusinessCardApp extends ConsumerWidget {
  const BusinessCardApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final theme = ref.watch(themeProvider);
    final brightness = ref.watch(brightnessProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Abdullah Alamary',
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: theme,
      darkTheme: theme, // Using same theme for now, can be customized
      themeMode: brightness == Brightness.dark 
          ? ThemeMode.dark 
          : ThemeMode.light,
      
      // Localization configuration
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocales.supportedLocales,
      
      // Router configuration
      routerConfig: router,
    );
  }
}
