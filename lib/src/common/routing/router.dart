import 'package:bloc_clean_architecture/src/common/functions/my_functions.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/presentation/add_cosmetic/view/add_cosmetic_view.dart';
import 'package:bloc_clean_architecture/src/presentation/bottom_navigation_bar/view/bottom_navigation_bar_view.dart';
import 'package:bloc_clean_architecture/src/presentation/home/view/home_view.dart';
import 'package:bloc_clean_architecture/src/presentation/login/view/login_view.dart';
import 'package:bloc_clean_architecture/src/presentation/profile/view/profile_view.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/presentation/sign_up/view/sign_up_view.dart';
import 'package:bloc_clean_architecture/src/presentation/splash/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final sectionHomeNavigatorKey = GlobalKey<NavigatorState>();
final sectionCosmeticsNavigatorKey = GlobalKey<NavigatorState>();
final sectionProfileNavigatorKey = GlobalKey<NavigatorState>();
final sectionPlansNavigatorKey = GlobalKey<NavigatorState>();
final popupManager = PopupManager(navigatorKey: rootNavigatorKey);
final overlayManager = OverlayManager(navigatorKey: rootNavigatorKey);

GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: [
    /// Splash route
    GoRoute(
      path: RoutePaths.splash.asRoutePath,
      name: RoutePaths.splash.name,
      builder: (context, state) => const SplashView(),
    ),

    /// Service unavailable route
    // GoRoute(
    //   path: RoutePaths.serviceUnavailable.asRoutePath,
    //   name: RoutePaths.serviceUnavailable.name,
    //   builder: (context, state) => const ServiceUnavailableView(),
    // ),

    /// Login route
    GoRoute(
      path: RoutePaths.login.asRoutePath,
      name: RoutePaths.login.name,
      builder: (context, state) => const LoginView(),
      routes: [
        GoRoute(
          path: RoutePaths.signUp.asRoutePath,
          name: RoutePaths.signUp.name,
          builder: (context, state) => const SignUpView(),
        ),
      ],
    ),

    /// Bottom navigation bar route
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavigationBarView(navigationShell: navigationShell);
      },
      branches: [
        /// Home branch
        StatefulShellBranch(
          navigatorKey: sectionHomeNavigatorKey,
          routes: [
            /// Home route
            GoRoute(
              path: RoutePaths.home.asRoutePath,
              name: RoutePaths.home.name,
              builder: (context, state) => const HomeView(),
            ),
          ],
        ),

        /// Add Cosmetics branch
        StatefulShellBranch(
          navigatorKey: sectionCosmeticsNavigatorKey,
          routes: [
            /// Add Cosmetics route
            GoRoute(
              path: RoutePaths.addCosmetics.asRoutePath,
              name: RoutePaths.addCosmetics.name,
              builder: (context, state) => const AddCosmeticView(),
            ),
          ],
        ),

        /// Add Plans branch
        StatefulShellBranch(
          navigatorKey: sectionPlansNavigatorKey,
          routes: [
            /// Add Cosmetics route
            GoRoute(
              path: RoutePaths.addPlans.asRoutePath,
              name: RoutePaths.addPlans.name,
              builder: (context, state) => Container(
                color: Colors.red,
              ),
            ),
          ],
        ),

        /// Profile branch
        StatefulShellBranch(
          navigatorKey: sectionProfileNavigatorKey,
          routes: [
            /// Profile route
            GoRoute(
              path: RoutePaths.profile.asRoutePath,
              name: RoutePaths.profile.name,
              builder: (context, state) => const ProfileView(),
            ),
          ],
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    final authenticationStatus = context.read<AuthBloc>().state.status;
    if (authenticationStatus == AuthenticationStatus.unAuthenticated) {
      final fullPath = state.fullPath;

      return switch (MyFunctions.convertFullPathToEnum(fullPath)) {
        RoutePaths.signUp || RoutePaths.login || RoutePaths.serviceUnavailable => null,
        _ => RoutePaths.login.asRoutePath,
      };
    }

    return null;
  },
  debugLogDiagnostics: true,
);
