import 'package:ecommerce_admin_app/core/constants/route_const.dart';
import 'package:ecommerce_admin_app/core/services/dependency_injection.dart';
import 'package:ecommerce_admin_app/src/banner/presentation/provider/banner_provider.dart';
import 'package:ecommerce_admin_app/src/banner/presentation/views/banner_view.dart';
import 'package:ecommerce_admin_app/src/category/presentation/provider/category_provider.dart';
import 'package:ecommerce_admin_app/src/category/presentation/views/category_view.dart';
import 'package:ecommerce_admin_app/src/dashboard/presentation/view/dashboard.dart';
import 'package:ecommerce_admin_app/src/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_admin_app/src/product/presentation/provider/product_create_provider.dart';
import 'package:ecommerce_admin_app/src/product/presentation/provider/product_provider.dart';
import 'package:ecommerce_admin_app/src/product/presentation/views/product_create_view.dart';
import 'package:ecommerce_admin_app/src/product/presentation/views/product_view.dart';
import 'package:ecommerce_admin_app/src/splash/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
        return RoutePath.home;
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
        return BlocProvider(
          create: (context) => sl<ProductBloc>(),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => sl<CategoryProvider>()),
            ],
            child: Dashboard(shell: shell),
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.product,
              name: RouteName.product,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => sl<ProductProvider>(),
                    child: const ProductView(),
                  ),
              routes: [
                GoRoute(
                  path: RoutePath.productCreate,
                  name: RouteName.productCreate,
                  pageBuilder:
                      (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: ChangeNotifierProvider(
                          create: (context) => sl<ProductCreateProvider>(),
                          child: const ProductCreateView(),
                        ),
                      ),
                ),
                GoRoute(
                  path: RoutePath.productEdit,
                  name: RouteName.productEdit,
                  builder: (context, state) => const Placeholder(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.category,
              name: RouteName.category,
              builder: (context, state) => const CategoryView(),
            ),
            GoRoute(
              path: RoutePath.categoryCreate,
              name: RouteName.categoryCreate,
              builder: (context, state) => const Placeholder(),
            ),
            GoRoute(
              path: RoutePath.categoryEdit,
              name: RouteName.categoryEdit,
              builder: (context, state) => const Placeholder(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.home,
              name: RouteName.home,
              builder: (context, state) => const Placeholder(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.banner,
              name: RouteName.banner,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (_) => sl<BannerProvider>(),
                    child: const BannerView(),
                  ),
            ),
            GoRoute(
              path: RoutePath.bannerCreate,
              name: RouteName.bannerCreate,
              builder: (context, state) => const Placeholder(),
            ),
            GoRoute(
              path: RoutePath.bannerEdit,
              name: RouteName.bannerEdit,
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
          ],
        ),
      ],
    ),
  ],
);
