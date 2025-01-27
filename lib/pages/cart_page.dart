import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../resources/order.dart';

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

class CartForm extends StatefulWidget {
  const CartForm({super.key});

  @override
  // ignore: no_logic_in_create_state
  CartFormState createState() => CartFormState();
}

class CartFormState extends State<CartForm> {
  CartFormState();

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    List<OrderedProduct> products = orderData.productsInfo.products;
    const isSelectable = true;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: products.length, // 商品の数
              itemBuilder: (context, index) {
                final product = products[index].product;
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
                                              final currentQuantity = orderData.getOrderedProductQuantity(product);
                                              if (currentQuantity > 0) {
                                                orderData.changeOrderedProduct(product, currentQuantity - 1);
                                              }
                                            });
                                          },
                                        ),
                                        // 現在の数量を表示
                                        Text(
                                          '${orderData.getOrderedProductQuantity(product)}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        // プラスボタン
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            setState(() {
                                              final currentQuantity = orderData.getOrderedProductQuantity(product);
                                              orderData.changeOrderedProduct(product, currentQuantity + 1);
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
                                          orderData.changeOrderedProduct(product, 0);
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
