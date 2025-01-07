import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_one/pages/product_page.dart';
import 'package:provider/provider.dart';
import '../resources/order.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);

    return Column(
      children: [
        // 広告バナー
        Container(
          height: 100,
          color: Colors.blueAccent,
          child: const Center(
            child: Text(
              '広告バナーなどという姑息な収益手段\nなんぞ取りおってからに  \\(゜□゜\\)',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        // ListView
        const Expanded(
          child: ProductPage(),
        ),
        // 確定ボタン部分
        Container(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // ボタン押下時の処理
                GoRouter.of(context).push('/cart');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 8.0),
                  const Icon(
                    Icons.shopping_cart,
                    size: 40.0,
                  ),
                  Text('${orderData.productsInfo.products.length} 個:  ￥${orderData.productsInfo.amount}'),
                ],
              )
            ),
          ),
        ),
      ],
    );
  }
}
