import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latin_one/helper/go_router_helper.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: const Text('LatinOne'),
        backgroundColor: Colors.orange,
        centerTitle: true,
        leading: (() {
          if (GoRouter.of(context).location == '/') {
            if (FirebaseAuth.instance.currentUser == null) {
              return IconButton(
                icon: const Icon(Icons.login),
                onPressed: () => GoRouter.of(context).push('/signin'),
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () => GoRouter.of(context).push('/account'),
              );
            }
          } else {
            return IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => GoRouter.of(context).go('/'),
            );
          }
        })(),
      ),

      //Body
      body: navigationShell,
    );
  }
}
