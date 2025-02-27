import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/home_page.dart';
import 'pages/order_page.dart';
import 'pages/store_page.dart';
import 'pages/product_page.dart';
import 'pages/account_page.dart';
import 'pages/layout.dart';
import 'pages/cart_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _contentNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'content');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
        path: "/account",
        builder: (BuildContext context, GoRouterState state) => const AccountPage()
    ),
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context,
                GoRouterState state,
                StatefulNavigationShell navigationShell)
      {
          return AppLayout(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          navigatorKey: _contentNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (BuildContext context, GoRouterState state) =>
                const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/store',
              builder: (BuildContext context, GoRouterState state) =>
                StorePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/order',
              builder: (BuildContext context, GoRouterState state) =>
                const OrderPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/product',
              builder: (BuildContext context, GoRouterState state) =>
                const ProductPage()
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/cart',
              builder: (BuildContext context, GoRouterState state) =>
                const CartPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
