import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../providers.dart';
import '../models/product.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('選択商品ページ'),
      ),
      body: const CartForm(),
    );
  }
}

class CartForm extends ConsumerStatefulWidget {
  const CartForm({super.key});

  @override
  CartFormState createState() => CartFormState();
}

class CartFormState extends ConsumerState<CartForm> {
  CartFormState();

  @override
  Widget build(BuildContext context) {
    const isSelectable = true;
    final orderData = ref.watch(orderProvider);
    final orderNotifier = ref.watch(orderProvider.notifier);
    final productsFuture = ref.watch(productProvider);

    final products = productsFuture.when(
      data: (data) => data,
      error: (error, stack) {
        Fluttertoast.showToast(msg: "エラーが発生しました: ${error.toString()}");
        return <Product>[];
      },
      loading: () {
        // ローディング中はスピナーを表示
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
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

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
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
                                visible: isSelectable,
                                child: Column(
                                  children: [
                                    Row(
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
                                    ),
                                    const SizedBox(height: 8.0),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        setState(() {
                                          orderNotifier.changeProduct(product, 0);
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
          )
        ),

        // 確定ボタン部分
        Container(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  // ボタン押下時の処理
                  GoRouter.of(context).push('/order');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 8.0),
                    Icon(
                      Icons.shopping_cart,
                      size: 40.0,
                    ),
                    Text('レジに進む'),
                  ],
                )
            ),
          ),
        ),
        // ListView
      ],
    );
  }
}
