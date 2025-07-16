import 'package:ecommerce_admin_app/core/constants/route_const.dart';
import 'package:ecommerce_admin_app/core/services/dependency_injection.dart';
import 'package:ecommerce_admin_app/src/banner/domain/entities/banner.dart';
import 'package:ecommerce_admin_app/src/banner/presentation/bloc/banner_bloc.dart';
import 'package:ecommerce_admin_app/src/banner/presentation/views/banner_form_view.dart';
import 'package:ecommerce_admin_app/src/banner/presentation/views/banner_view.dart';
import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:ecommerce_admin_app/src/category/presentation/bloc/category_bloc.dart';
import 'package:ecommerce_admin_app/src/category/presentation/provider/category_provider.dart';
import 'package:ecommerce_admin_app/src/category/presentation/views/category_form_view.dart';
import 'package:ecommerce_admin_app/src/category/presentation/views/category_view.dart';
import 'package:ecommerce_admin_app/src/dashboard/presentation/view/dashboard.dart';
import 'package:ecommerce_admin_app/src/home/presentation/views/home_view.dart';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';
import 'package:ecommerce_admin_app/src/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_admin_app/src/product/presentation/views/product_form_view.dart';
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
        return RoutePath.home;
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) {
        return ChangeNotifierProvider(
          create: (_) => sl<CategoryProvider>(),
          child: Dashboard(shell: shell),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.product,
              name: RouteName.product,
              builder:
                  (context, state) => BlocProvider(
                    create:
                        (context) =>
                            sl<ProductBloc>()..add(const GetProductsEvent()),
                    child: const ProductView(),
                  ),
              routes: [
                GoRoute(
                  path: RoutePath.productCreate,
                  name: RouteName.productCreate,
                  pageBuilder:
                      (context, state) => NoTransitionPage(
                        key: state.pageKey,
                        child: BlocProvider(
                          create: (context) => sl<ProductBloc>(),
                          child: const ProductFormView(),
                        ),
                      ),
                ),
                GoRoute(
                  path: RoutePath.productEdit,
                  name: RouteName.productEdit,
                  pageBuilder: (context, state) {
                    final product = state.extra! as Product;
                    return NoTransitionPage(
                      key: state.pageKey,
                      child: BlocProvider(
                        create: (context) => sl<ProductBloc>(),
                        child: ProductFormView(product: product),
                      ),
                    );
                  },
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
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  key: state.pageKey,
                  child: BlocProvider(
                    create: (context) => sl<CategoryBloc>(),
                    child: const CategoryFormView(),
                  ),
                );
              },
            ),
            GoRoute(
              path: RoutePath.categoryEdit,
              name: RouteName.categoryEdit,
              pageBuilder: (context, state) {
                final category = state.extra! as CategoryEntity;
                return NoTransitionPage(
                  key: state.pageKey,
                  child: BlocProvider(
                    create: (context) => sl<CategoryBloc>(),
                    child: CategoryFormView(category: category),
                  ),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.home,
              name: RouteName.home,
              builder: (context, state) => const HomeView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.banner,
              name: RouteName.banner,
              builder:
                  (context, state) => BlocProvider(
                    create: (_) => sl<BannerBloc>(),
                    child: const BannerView(),
                  ),
            ),
            GoRoute(
              path: RoutePath.bannerCreate,
              name: RouteName.bannerCreate,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  key: state.pageKey,
                  child: const BannerFormView(),
                );
              },
            ),
            GoRoute(
              path: RoutePath.bannerEdit,
              name: RouteName.bannerEdit,
              pageBuilder: (context, state) {
                final banner = state.extra! as BannerEntity;
                return NoTransitionPage(
                  key: state.pageKey,
                  child: BannerFormView(banenr: banner),
                );
              },
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
