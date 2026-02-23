import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../providers.dart';

class AppLayout extends ConsumerWidget {
  final Widget child;

  const AppLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // AppBar
      appBar: AppBar(

        title: const Text('LatinOne'),
        backgroundColor: Colors.orange,
        centerTitle: true,

      //   leading: Consumer(
      //     builder: (context, ref, child) {
      //       ref.watch(userProvider).when(
      //         data: (user) {
      //           if (user != null) {
      //             return IconButton(
      //               icon: const Icon(Icons.account_circle),
      //               onPressed: () {
      //                 GoRouter.of(context).go('/accout');
      //               },
      //             );
      //           } else {
      //             return IconButton(
      //               icon: const Icon(Icons.login),
      //               onPressed: () {
      //                 GoRouter.of(context).go('/signin');
      //               },
      //             );
      //           }
      //         },
      //         loading: () {
      //           return IconButton(
      //             icon: const Icon(Icons.login),
      //             onPressed: () {
      //               GoRouter.of(context).go('/signin');
      //             },
      //           );
      //         },
      //         error: (error, stackTrace) {
      //           Fluttertoast.showToast(msg: "エラーが発生しました: ${error.toString()}");
      //           return IconButton(
      //             icon: const Icon(Icons.login),
      //             onPressed: () {
      //               GoRouter.of(context).go('/signin');
      //             },
      //           );
      //         },
      //       );
      //       return Container(); // Unreachable but neccessary
      //     },
      //   ),
      ),

      body: child,
    );
  }
}
