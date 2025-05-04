import 'package:fake_store/core/config/app_pages.dart';
import 'package:fake_store/core/shared/constants/cach_helper.dart';
import 'package:fake_store/features/auth/presentation/screens/login_screen.dart';
import 'package:fake_store/features/favourites/presentation/screen/favourites_screen.dart';
import 'package:fake_store/features/home/presentation/screens/home_screen.dart';
import 'package:fake_store/features/product_details/presentation/screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';

final GoRouter router = GoRouter(
  initialLocation:
      CacheHelper().isLoggedIn == false ? Routes.login : Routes.home,

  routes: <RouteBase>[
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 1000),
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.linear).animate(animation),
              child: child,
            );
          },
        );
      },
    ),

    GoRoute(
      path: Routes.productDetails,
      pageBuilder: (context, state) {
        final product = state.extra as ProductEntity;
        return MaterialPage(
          key: state.pageKey,
          child: ProductDetailsScreen(product: product),
        );
      },
    ),

    GoRoute(
      path: Routes.favorites,
      builder: (context, state) => const FavoriteProductsScreen(),
    ),
  ],
);
