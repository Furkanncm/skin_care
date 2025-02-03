import 'package:bloc_clean_architecture/src/common/functions/my_functions.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/presentation/bottom_navigation_bar/view/bottom_navigation_bar_view.dart';
import 'package:bloc_clean_architecture/src/presentation/home/view/home_view.dart';
import 'package:bloc_clean_architecture/src/presentation/login/view/login_view.dart';
import 'package:bloc_clean_architecture/src/presentation/profile/view/profile_edit_view.dart';
import 'package:bloc_clean_architecture/src/presentation/profile/view/profile_view.dart';
import 'package:bloc_clean_architecture/src/presentation/settings/view/settings_view.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/presentation/sign_up/view/sign_up_view.dart';
import 'package:bloc_clean_architecture/src/presentation/splash/view/splash_view.dart';
import 'package:bloc_clean_architecture/src/presentation/todo/view/todo_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final sectionHomeNavigatorKey = GlobalKey<NavigatorState>();
final sectionSettingsNavigatorKey = GlobalKey<NavigatorState>();
final sectionProfileNavigatorKey = GlobalKey<NavigatorState>();
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
              routes: [
                /// To do route
                GoRoute(
                  path: RoutePaths.todo.asRoutePath,
                  name: RoutePaths.todo.name,
                  builder: (context, state) => const TodoView(),
                ),

                /// Post route
                // GoRoute(
                //   path: RoutePaths.post.asRoutePath,
                //   name: RoutePaths.post.name,
                //   builder: (context, state) => const PostView(),
                //   routes: [
                //     /// Comment route
                //     GoRoute(
                //       path: RoutePaths.comment.asRoutePath,
                //       name: RoutePaths.comment.name,
                //       builder: (context, state) => CommentView(post: state.extra! as Post),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),

        /// Settings branch
        StatefulShellBranch(
          navigatorKey: sectionSettingsNavigatorKey,
          routes: [
            /// Settings route
            GoRoute(
              path: RoutePaths.settings.asRoutePath,
              name: RoutePaths.settings.name,
              builder: (context, state) => const SettingsView(),
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
              routes: [
                /// profile edit route
                GoRoute(
                  path: RoutePaths.profileEdit.asRoutePath,
                  name: RoutePaths.profileEdit.name,
                  builder: (context, state) => const ProfileEditView(),
                  parentNavigatorKey: rootNavigatorKey,
                ),
              ],
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
