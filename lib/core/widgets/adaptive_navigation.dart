import 'package:flutter/material.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/breakpoints.dart';

/// A navigation widget that adapts to screen size.
/// Uses a Drawer on mobile and a customized navigation solution for larger screens.
/// Note: This is a scaffold wrapper that handles the body and navigation.
class AdaptiveNavigationScaffold extends StatelessWidget {
  const AdaptiveNavigationScaffold({
    super.key,
    required this.body,
    required this.title,
    required this.destinations,
    required this.onDestinationSelected,
    required this.selectedIndex,
    this.floatingActionButton,
    this.actions,
  });

  final Widget body;
  final String title;
  final List<NavigationDestination> destinations;
  final ValueChanged<int> onDestinationSelected;
  final int selectedIndex;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileLayout(context),
      tablet: _buildTabletLayout(context),
      desktop: _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        items: destinations.map((d) {
          return BottomNavigationBarItem(
            icon: d.icon,
            activeIcon: d.selectedIcon,
            label: d.label,
          );
        }).toList(),
        currentIndex: selectedIndex,
        onTap: onDestinationSelected,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
      floatingActionButton: floatingActionButton,
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: Row(
        children: [
          NavigationRail(
            destinations: destinations.map((d) {
              return NavigationRailDestination(
                icon: d.icon,
                selectedIcon: d.selectedIcon,
                label: Text(d.label),
              );
            }).toList(),
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(child: body),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    // Desktop could be same as tablet or have a top navbar.
    // Let's stick to NavigationRail for standard tablet/desktop consistency for now,
    // but maybe extended label type?
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            destinations: destinations.map((d) {
              return NavigationRailDestination(
                icon: d.icon,
                selectedIcon: d.selectedIcon,
                label: Text(d.label),
              );
            }).toList(),
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(
            child: Column(
              children: [
                AppBar(
                  title: Text(title),
                  actions: actions,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                ),
                Expanded(child: body),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
