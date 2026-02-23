import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import 'widgets/product_list.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final user = ref.watch(userProvider);

    return Column(
      children: [

        // 広告バナー
        Container(
          height: 100,
          color: Colors.blueAccent,
          child: const Center(
            child: Text(
              '広告バナー',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),

        // ListView
        const Expanded(
          child: ProductList(page: false),
        ),

        // 確定ボタン部分
        Container(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push('/store');
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 8.0),
                  Icon(
                    Icons.store,
                    size: 40.0,
                  ),
                  Text('店舗選択画面'),
                ],
              )
            ),
          ),
        ),
      ],
    );
  }
}
