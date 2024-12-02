import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resources/product.dart';
import '../db/firebase/connector.dart';
import '../resources/order.dart' as order;

class ProductPage extends StatelessWidget {
  final bool isSelectable;
  const ProductPage({super.key, required this.isSelectable});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品ページ'),
      ),
      body: ProductForm(isSelectable),
    );
  }
}

class ProductForm extends StatefulWidget {
  final bool isSelectable;
  const ProductForm(this.isSelectable, {super.key});

  @override
  // ignore: no_logic_in_create_state
  ProductFormState createState() => ProductFormState(isSelectable);
}

class ProductFormState extends State<ProductForm> {
  late Future<List<Product>> future;

  bool isSelectable;
  ProductFormState(this.isSelectable);

  @override
  initState() {
    var db = FirebaseFirestore.instance;
    future = fetchProduct(db);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<order.Order>(context);

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data found'));
        }

        List<Product> products = snapshot.data!;
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
                      visible: isSelectable,
                      child: Row(
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
                      )
                    ),
                  ],
                )
              )
            );
          }
        );
    });
  }
}
