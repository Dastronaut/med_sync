import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:med_sync/features/auth/presentation/pages/sign_in_page.dart';
import 'package:med_sync/features/welcome/presentation/pages/welcome_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRouter {
  static GoRouter router(bool isFirstLaunch) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: isFirstLaunch ? '/welcome' : '/sign-in',
      routes: [
        GoRoute(
          path: '/welcome',
          name: 'welcome',
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: '/sign-in',
          name: 'sign-in',
          builder: (context, state) => const SignInPage(),
        ),
        // Add more routes here as needed
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('Error: ${state.error}'),
        ),
      ),
    );
  }
} 