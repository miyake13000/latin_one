import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/home_page.dart';
import 'pages/order_page.dart';
import 'pages/store_page.dart';
import 'pages/product_page.dart';
import 'pages/signin_page.dart';
import 'pages/account_page.dart';
import 'pages/layout.dart';
import 'pages/cart_page.dart';

final GlobalKey<NavigatorState> _navigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter router = GoRouter(
  navigatorKey: _navigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const AppLayout(child: HomePage()),
    ),
    GoRoute(
      path: '/store',
      builder: (BuildContext context, GoRouterState state) => const AppLayout(child: StorePage()),
    ),
    GoRoute(
      path: '/order',
      builder: (BuildContext context, GoRouterState state) => const AppLayout(child: OrderPage()),
    ),
    GoRoute(
      path: '/product',
      builder: (BuildContext context, GoRouterState state) => const AppLayout(child: ProductPage()),
    ),
    GoRoute(
      path: '/cart',
      builder: (BuildContext context, GoRouterState state) => const AppLayout(child: CartPage()),
    ),
    GoRoute(
      path: '/signin',
      builder: (BuildContext context, GoRouterState state) => const AppLayout(child: SigninPage()),
    ),
    GoRoute(
      path: '/account',
      builder: (BuildContext context, GoRouterState state) => const AppLayout(child: AccountPage()),
    ),
  ],
);
