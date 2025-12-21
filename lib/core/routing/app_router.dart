import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/business_card/presentation/business_card_page.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../widgets/app_shell.dart';

/// Application route paths
/// 
/// To add a new route:
/// 1. Add a path constant here
/// 2. Add a route in the router configuration
/// 3. Create the corresponding page/screen
class AppRoutes {
  static const String home = '/';
  static const String settings = '/settings';
}

/// Application router configuration
/// 
/// This file contains all routing configuration using go_router.
/// To add a new route, add an entry to the routes list.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(state: state, child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => const BusinessCardPage(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            name: 'settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
  );
});

