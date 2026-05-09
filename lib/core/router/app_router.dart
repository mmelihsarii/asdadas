import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/supabase_service.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/profile/presentation/profile_setup_screen.dart';
import '../../features/explore/presentation/explore_screen.dart';
import '../../features/match_listings/presentation/match_listing_create_screen.dart';
import '../../features/match_listings/presentation/match_listing_detail_screen.dart';
import '../../features/player_listings/presentation/player_listing_create_screen.dart';
import '../../features/offers/presentation/offers_screen.dart';
import '../../features/my_matches/presentation/my_matches_screen.dart';
import '../../features/messages/presentation/messages_list_screen.dart';
import '../../features/messages/presentation/chat_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/user_profile_screen.dart';
import 'app_shell.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // DEVELOPMENT MODE - Disable authentication checks
      const isDevelopmentMode = true; // Set to false for production

      if (isDevelopmentMode) {
        // In dev mode, allow access to all routes except redirect authenticated users from login
        final isGoingToLogin = state.matchedLocation == '/login';
        final isAuthenticated = SupabaseService.instance.isAuthenticated;

        if (isAuthenticated && isGoingToLogin) {
          return '/explore';
        }
        return null; // Allow all other routes
      }

      // PRODUCTION MODE - Normal authentication flow
      final isAuthenticated = SupabaseService.instance.isAuthenticated;
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToRoot = state.matchedLocation == '/';

      // If not authenticated and not going to login, redirect to login
      if (!isAuthenticated && !isGoingToLogin && !isGoingToRoot) {
        return '/login';
      }

      // If authenticated and going to login, redirect to explore
      if (isAuthenticated && isGoingToLogin) {
        return '/explore';
      }

      return null;
    },
    routes: [
      // Landing/Root
      GoRoute(
        path: '/',
        builder: (context, state) {
          final isAuthenticated = SupabaseService.instance.isAuthenticated;
          if (isAuthenticated) {
            // Redirect to explore if authenticated
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/explore');
            });
          }
          return const LoginScreen(); // Show login as landing
        },
      ),

      // Login
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

      // Profile Setup (first time users)
      GoRoute(
        path: '/profile-setup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),

      // Main app shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          // Explore (Home)
          GoRoute(
            path: '/explore',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ExploreScreen(),
            ),
          ),

          // My Matches
          GoRoute(
            path: '/my-matches',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const MyMatchesScreen(),
            ),
          ),

          // Offers
          GoRoute(
            path: '/offers',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const OffersScreen(),
            ),
          ),

          // Messages List
          GoRoute(
            path: '/messages',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const MessagesListScreen(),
            ),
          ),

          // Profile
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ProfileScreen(),
            ),
          ),
        ],
      ),

      // Match Listing Create
      GoRoute(
        path: '/match-listings/new',
        builder: (context, state) => const MatchListingCreateScreen(),
      ),

      // Match Listing Detail
      GoRoute(
        path: '/match-listings/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return MatchListingDetailScreen(matchId: id);
        },
      ),

      // Player Listing Create
      GoRoute(
        path: '/player-listings/new',
        builder: (context, state) => const PlayerListingCreateScreen(),
      ),

      // Chat Detail
      GoRoute(
        path: '/messages/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          // TODO: Fetch user name from provider
          return ChatScreen(userId: id, userName: 'Kullanıcı');
        },
      ),

      // User Profile (other users)
      GoRoute(
        path: '/users/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return UserProfileScreen(userId: id);
        },
      ),
    ],
  );
}
