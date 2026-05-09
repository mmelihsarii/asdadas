import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sahada_dev/core/widgets/glass_bottom_nav.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: GlassBottomNav(
        currentIndex: _getCurrentIndex(location),
        onTap: (index) => _onNavTap(context, index),
        items: const [
          GlassBottomNavItem(
            icon: Icons.explore_outlined,
            activeIcon: Icons.explore,
            label: 'Keşfet',
          ),
          GlassBottomNavItem(
            icon: Icons.sports_soccer_outlined,
            activeIcon: Icons.sports_soccer,
            label: 'Maçlarım',
          ),
          GlassBottomNavItem(
            icon: Icons.local_offer_outlined,
            activeIcon: Icons.local_offer,
            label: 'Teklifler',
          ),
          GlassBottomNavItem(
            icon: Icons.chat_bubble_outline,
            activeIcon: Icons.chat_bubble,
            label: 'Sohbet',
          ),
          GlassBottomNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(String location) {
    if (location.startsWith('/explore')) return 0;
    if (location.startsWith('/my-matches')) return 1;
    if (location.startsWith('/offers')) return 2;
    if (location.startsWith('/messages')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/explore');
        break;
      case 1:
        context.go('/my-matches');
        break;
      case 2:
        context.go('/offers');
        break;
      case 3:
        context.go('/messages');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }
}
