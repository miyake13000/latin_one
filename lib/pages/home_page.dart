import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_one/resources/product_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

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
                // ボタン押下時の処理
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
