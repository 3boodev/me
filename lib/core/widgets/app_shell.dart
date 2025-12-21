import 'package:business_card/core/localization/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../localization/app_localizations.dart';
import '../routing/app_router.dart';
import '../utils/share_utils.dart';
import '../../data/config/personal_config.dart';
import 'adaptive_navigation.dart';

/// App Shell that provides adaptive navigation around the main content
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
    required this.state,
  });

  final Widget child;
  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    // Handle null localizations gracefully (e.g. during init)
    final loc = localizations ?? AppLocalizationsEn(); // Fallback if needed, though usually available

    final currentPath = state.uri.path;
    final isSettings = currentPath == AppRoutes.settings;
    final selectedIndex = isSettings ? 1 : 0;

    return AdaptiveNavigationScaffold(
      title: isSettings ? loc.settings : loc.appTitle,
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        if (index == 0) {
          context.go(AppRoutes.home);
        } else {
          context.go(AppRoutes.settings);
        }
      },
      destinations: [
        NavigationDestination(
          icon:  Image.asset('assets/images/un_home.png',color: Colors.cyan,),
          selectedIcon:  Image.asset('assets/images/home.png',color: Colors.white,),
          label: loc.home, // Assuming 'home' exists or similar
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings,color: Colors.cyan,),
          selectedIcon: const Icon(Icons.settings,color:Colors.white),
          label: loc.settings,
        ),
      ],
      actions: isSettings 
          ? [] 
          : [
              IconButton(
                icon: const Icon(Icons.share),
                tooltip: loc.share,
                onPressed: () => _shareBusinessCard(context, loc),
              ),
            ],
      body: child,
    );
  }

  Future<void> _shareBusinessCard(BuildContext context, AppLocalizations loc) async {
    final website = PersonalConfig.profile.website ?? '';
    final url = website.isNotEmpty ? website : 'https://example.com';
    
    await ShareUtils.shareBusinessCard(
      url: url,
      title: '${PersonalConfig.profile.name} - ${loc.appTitle}',
      text: '${PersonalConfig.profile.name}\n${PersonalConfig.profile.jobTitle}',
    );
  }
}

// Helper for fallback if needed, or better to just ensure localizations are loaded.
// Implementation note: The Shell is below MaterialApp, so Localizations should be found.
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn() : super(Locale('en'));

  @override String get appTitle => 'Business Card';
  @override String get settings => 'Settings';
  @override String get share => 'Share';
  @override String get theme => 'Theme';
  @override String get lightMode => 'Light Mode';
  @override String get darkMode => 'Dark Mode';
  @override String get systemMode => 'System Mode';
  @override String get language => 'Language';
  @override String get english => 'English';
  @override String get arabic => 'Arabic';
  @override String get name => 'Name';
  @override String get jobTitle => 'Job Title';
  @override String get email => 'Email';
  @override String get phone => 'Phone';
  @override String get website => 'Website';
  @override String get address => 'Address';
  @override String get home => 'Home';
}
