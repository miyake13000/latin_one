import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resources/product.dart';
import '../resources/order.dart';

// 商品リストのサンプルデータ
final List<Product> products = [
  Product(1, '豆A', '浅煎り', 500, '薄茶色'),
  Product(2, '豆B', '中煎り', 600, '茶色'),
  Product(3, '豆C', '深煎り', 700, '焦げ茶色'),
];

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品ページ'),
      ),
      body: const ProductForm(),
        );
  }
}

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  ProductFormState createState() => ProductFormState();
}

class ProductFormState extends State<ProductForm> {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);

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
              ],
            )
          )
        );
      }
    );
  }
}
