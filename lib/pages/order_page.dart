import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../resources/order.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('注文ページ'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: OrderForm(),
        ),
      ),
    );
  }
}

class OrderForm extends StatelessWidget {
  const OrderForm({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 店舗選択ボタン
        StoreSelectButton(orderData.storeId),
        const SizedBox(height: 16.0),

        // 商品選択ボタン
        ProductSelectButton(orderData.products),
        const SizedBox(height: 16.0),

        // 支払い方法選択
        const Text('支払い方法を選択'),
        const DropdownButtonOrder(
          items: ['現金', 'クレジットカード', 'PayPay'],
        ),
        const SizedBox(height: 16.0),

        // 氏名入力
        const Text('氏名を入力'),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '氏名',
          ),
        ),
        const SizedBox(height: 16.0),

        // 住所入力
        const Text('住所を入力'),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '住所',
          ),
        ),
        const SizedBox(height: 16.0),

        // 決定ボタン
        SubmitButton(orderData),
      ],
    );
  }

}
class StoreSelectButton extends StatelessWidget {
  final int? storeId;

  const StoreSelectButton(this.storeId, {super.key});

  @override
  Widget build(BuildContext context) {
    String text;
    if (storeId == null) {
      text = '店舗を選択';
    } else {
      text = '店舗を選択済み';
    }

    return SizedBox(
      width: double.infinity, // ボタンを横幅いっぱいに広げる
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // 四角にするために角丸を0に設定
          ),
        ),
        onPressed: () {
          GoRouter.of(context).go('/store');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            const SizedBox(width: 8.0),
            const Icon(Icons.arrow_circle_right),
          ],
        ),
      ),
    );
  }
}

class ProductSelectButton extends StatelessWidget {
  final List<OrderedProduct> products;

  const ProductSelectButton(this.products, {super.key});

  @override
  Widget build(BuildContext context) {
    String text;
    if (products.isEmpty) {
      text = '商品を選択';
    } else {
      text = '商品を選択済み';
    }

    return SizedBox(
      width: double.infinity, // ボタンを横幅いっぱいに広げる
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // 四角にするために角丸を0に設定
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('商品選択'),
                content: const Text('商品選択画面に遷移したいね．'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            const SizedBox(width: 8.0),
            const Icon(Icons.arrow_circle_right),
          ],
        ),
      ),
    );
  }
}

class DropdownButtonOrder extends StatefulWidget {
  final List<String> items;

  const DropdownButtonOrder({super.key, required this.items});

  @override
  _DropdownButtonOrderState createState() => _DropdownButtonOrderState();
}

class _DropdownButtonOrderState extends State<DropdownButtonOrder> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: const Text('選択してください'), // 初期状態のテキスト
      value: _selectedItem,
      onChanged: (String? newValue) {
        setState(() {
          _selectedItem = newValue;
        });
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final Order orderData;

  const SubmitButton(this.orderData, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // ボタンを横幅いっぱいに広げる
      child: ElevatedButton(
        onPressed: () {
          // ボタン押下時の処理
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('確認'),
                content: const Text('注文確認画面に遷移したいね．'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: const Text('決定'),
      ),
    );
  }
}
