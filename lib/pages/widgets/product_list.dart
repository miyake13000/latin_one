import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../providers.dart';
import '../../models/product.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.page});
  final bool page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品ページ'),
      ),
      body: ProductListForm(page: page),
    );
  }
}

class ProductListForm extends ConsumerStatefulWidget {
  const ProductListForm({super.key, required this.page});
  final bool page;

  @override
  // ignore: no_logic_in_create_state
  ProductListFormState createState() => ProductListFormState(page);
}

class ProductListFormState extends ConsumerState<ProductListForm> {
  ProductListFormState(this.page);
  bool page;

  @override
  Widget build(BuildContext context) {
    final productsFuture = ref.watch(productProvider);
    final orderData = ref.watch(orderProvider);
    final orderNotifier = ref.watch(orderProvider.notifier);

    final products = productsFuture.when(
      data: (data) => data,
      error: (error, stack) {
        Fluttertoast.showToast(
          msg: "エラーが発生しました: ${error.toString()}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return <Product>[];
      },
      loading: () {
        // ローディング中はスピナーを表示
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        });
        return <Product>[];
      },
    );

    // ローディングが終わったらダイアログを閉じる
    if (!productsFuture.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context, rootNavigator: true).pop();
      });
    }

    return ListView.builder(
      itemCount: products.length, // 商品の数
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // アイコン
                const Icon(
                  Icons.shopping_cart,
                  size: 50.0,
                ),
                const SizedBox(width: 16.0),
                // 商品名、説明、値段を含むColumn
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 商品名
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      // 商品説明
                      Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      // 値段
                      Text(
                        '¥${product.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 16.0),
                // 数量の増減ボタンと表示
                Visibility(
                  visible: page,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // マイナスボタン
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          final currentQuantity = orderData.getQuantity(product);
                          if (currentQuantity > 0) {
                            orderNotifier.changeProduct(product, currentQuantity - 1);
                          }
                        });
                      },
                    ),
                    // 現在の数量を表示
                    Text(
                      '${orderData.getQuantity(product)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    // プラスボタン
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          final currentQuantity = orderData.getQuantity(product);
                          orderNotifier.changeProduct(product, currentQuantity + 1);
                          }
                        );
                      },
                    ),
                  ],
                  )
                ),
              ],
            )
          )
        );
      }
    );
  }
}
