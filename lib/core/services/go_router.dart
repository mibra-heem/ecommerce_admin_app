import 'package:ecommerce_admin_app/core/constants/route_const.dart';
import 'package:ecommerce_admin_app/src/dashboard/presentation/view/dashboard.dart';
import 'package:ecommerce_admin_app/src/splash/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: RoutePath.splash,
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: RoutePath.splash,
      name: RouteName.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: RoutePath.initial,
      name: RouteName.initial,
      redirect: (context, state) {
        // if (sl<FirebaseAuth>().currentUser != null) {
        //   debugPrint('Before startListening method................');
        //   // sl<ThemeProvider>().loadTheme();
        //   // sl<AudioCallProvider>().listeningForCall(context);
        //   // sl<AudioCallProvider>().listeningToCallReject(context);
        //   // sl<AudioCallProvider>().listenToCallerHangupBeforeAnswer(context);

        //   return RoutePath.chat;
        // }
        return RoutePath.signIn;
      },
    ),
    // GoRoute(
    //   path: RoutePath.signIn,
    //   name: RouteName.signIn,
    //   builder:
    //       (context, state) => BlocProvider(
    //         create: (context) => sl<AuthBloc>(),
    //         child: const SignInScreen(),
    //       ),
    // ),
    // GoRoute(
    //   path: RoutePath.signUp,
    //   name: RouteName.signUp,
    //   builder:
    //       (context, state) => BlocProvider(
    //         create: (context) => sl<AuthBloc>(),
    //         child: const SignUpScreen(),
    //       ),
    // ),
    // GoRoute(
    //   path: RoutePath.forgetPassword,
    //   name: RouteName.forgetPassword,
    //   builder:
    //       (context, state) => BlocProvider(
    //         create: (context) => sl<AuthBloc>(),
    //         child: const ForgotPasswordScreen(),
    //       ),
    // ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) {
        return Dashboard(shell: shell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.chat,
              name: RouteName.chat,
              builder: (context, state) => const Placeholder(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.profile,
              name: RouteName.profile,
              builder: (context, state) => const Placeholder(),
            ),
            // GoRoute(
            //   path: RoutePath.editProfile,
            //   name: RouteName.editProfile,
            //   builder:
            //       (context, state) => BlocProvider(
            //         create: (context) => sl<AuthBloc>(),
            //         child: ChangeNotifierProvider(
            //           create: (_) => ChangeNotifier(),
            //           child: const Placeholder(),
            //         ),
            //       ),
            // ),
            GoRoute(
              path: RoutePath.favourite,
              name: RouteName.favourite,
              builder:
                  (context, state) =>
                      const Center(child: Text('Favourite View')),
            ),
            GoRoute(
              path: RoutePath.notification,
              name: RouteName.notification,
              builder:
                  (context, state) =>
                      const Center(child: Text('Notification View')),
            ),
            GoRoute(
              path: RoutePath.privacy,
              name: RouteName.privacy,
              builder:
                  (context, state) => const Center(child: Text('Privacy View')),
            ),
          ],
        ),
      ],
    ),
  ],
);
