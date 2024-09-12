import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('注文ページ'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: OrderForm(), // フォームウィジェットを配置
      ),
    );
  }
}

class OrderForm extends StatelessWidget {
  const OrderForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 店舗選択
        const Text('店舗を選択'),
        const DropdownButtonOrder(
          items: ['A', 'B'],
        ),
        SizedBox(height: 16.0),

        // 商品選択
        const Text('商品を選択'),
        const DropdownButtonOrder(
          items: ['1', '2'],
        ),
        SizedBox(height: 16.0),

        // 支払い方法選択
        const Text('支払い方法を選択'),
        const DropdownButtonOrder(
          items: ['現金', 'クレジットカード'],
        ),
        SizedBox(height: 16.0),

        // 氏名入力
        const Text('氏名を入力'),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '氏名',
          ),
        ),
        SizedBox(height: 16.0),

        // 住所入力
        const Text('住所を入力'),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '住所',
          ),
        ),
        SizedBox(height: 16.0),

        // 決定ボタン
        SizedBox(
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
        ),
      ],
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
