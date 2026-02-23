import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../models/order.dart';
import '../models/store.dart';

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

class OrderForm extends ConsumerStatefulWidget {
  const OrderForm({super.key});

  @override
  OrderFormState createState() => OrderFormState();
}

class OrderFormState extends ConsumerState<OrderForm> {
  final addressController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final orderData = ref.watch(orderProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 商品表示
        DisplayCurrentProducts(order: orderData),
        const SizedBox(height: 24.0),

        // 店舗表示
        DisplayCurrentStore(store: orderData.store),
        const SizedBox(height: 16.0),

        // 支払い方法選択
        const Text('支払い方法を選択'),
        PaymentMethodDropdown(
          methods: const ['現金', 'クレジットカード', 'PayPay'],
          order: orderData,
        ),
        const SizedBox(height: 16.0),

        // 氏名入力
        const Text('氏名を入力'),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '氏名',
          ),
        ),
        const SizedBox(height: 16.0),

        // 住所入力
        const Text('住所を入力'),
        TextField(
          controller: addressController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '住所',
          ),
        ),
        const SizedBox(height: 16.0),

        // 決定ボタン
        SubmitButton(
          nameController.text,
          addressController.text,
        ),
      ],
    );
  }

}
class DisplayCurrentStore extends StatelessWidget {
  final Store? store;

  const DisplayCurrentStore({required this.store, super.key});

  @override
  Widget build(BuildContext context) {
    if (store == null) {
      return const SizedBox.shrink();
    } else {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("店舗情報"),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text("店舗名    "),
                        Text("住所")
                      ]
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(store!.name),
                        Text(store!.address)
                      ]
                    )
                ]
            )
          ]
      );
    }
  }
}

class DisplayCurrentProducts extends StatelessWidget {
  final Order order;

  const DisplayCurrentProducts({required this.order, super.key});

  @override
  Widget build(BuildContext context) {

    if (order.products.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Column(
        children:[
          const Align(alignment: Alignment.centerLeft,
                child:Text('商品情報',textAlign: TextAlign.left)
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var product in order.products)
                  Row(
                    children: [
                      // 商品名（左揃え）
                      Expanded(
                        child: Text(
                          product.product.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      // 数量（右揃え）
                      SizedBox(
                        width: 100,
                        child: Text(
                          '${product.quantity}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      // 価格（右揃え）
                       SizedBox(
                         width: 100,
                         child: Text(
                          '¥${product.product.price*product.quantity}',
                           textAlign: TextAlign.right,
                           style: const TextStyle(fontSize: 16),
                         ),
                       ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black, // 線の色
                    thickness: 1,       // 線の太さ
                    indent: 0,          // 左側の余白
                    endIndent: 0,       // 右側の余白
                  ),

              ]
              ),
          Align(alignment: Alignment.centerRight,
                child:Text('合計金額: ¥${order.ammount()}')
          )
        ],
      );
    }
  }
}

class PaymentMethodDropdown extends ConsumerStatefulWidget {
  final List<String> methods;
  final Order? order;

  const PaymentMethodDropdown({super.key, required this.methods, this.order});
  @override
  PaymentMethodDropdownState createState() => PaymentMethodDropdownState();
}

class PaymentMethodDropdownState extends ConsumerState<PaymentMethodDropdown> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    final orderNotifier = ref.read(orderProvider.notifier);
    return DropdownButton<String>(
      hint: const Text('選択してください'), // 初期状態のテキスト
      value: selectedItem,
      onChanged: (String? newValue) {
        setState(() {
          selectedItem = newValue;
        });
        orderNotifier.changePay(newValue!);
      },
      items: widget.methods.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class SubmitButton extends ConsumerWidget {
  final String name;
  final String address;

  const SubmitButton(
    this.name,
    this.address,
    {super.key}
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderData = ref.watch(orderProvider);
    final orderNotifier = ref.watch(orderProvider.notifier);
    orderNotifier.changeName(name);
    orderNotifier.changeAddress(address);

    return SizedBox(
      width: double.infinity, // ボタンを横幅いっぱいに広げる
      child: ElevatedButton(
        onPressed:() =>
        {
          if(isOrderDataCompleted(orderData)){
            urlLauncherMail(orderData)
          }else{
            displayDialog(context, "入力されていない情報があります")
          }
        },
        child: const Text('決定'),
      ),
    );
  }

  void displayDialog(BuildContext context, String log){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('確認'),
          content: Text(log),
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
  }

  Future<void> urlLauncherMail(Order orderData) async {
    final String productText =
    orderData.products.map((product) => '   + ${product.product.name} - ¥${product.product.price} - ${product.quantity}個').join('\n');

    Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: '${orderData.store?.email}',
      queryParameters: {
        'subject': '注文票',
        'body': '+ 氏名: ${orderData.name}\n'
            '+ 住所: ${orderData.address}\n'
            '+ お支払方法: ${orderData.pay}\n'
            '+ 購入店舗: ${orderData.store?.name}\n'
            '+ 購入商品:\n$productText\n'
            '+ 合計金額: ${orderData.ammount()}\n'
      },
    );
    final encodedUri = emailLaunchUri.toString().replaceAll('+', '%20');
    emailLaunchUri =  Uri.parse(encodedUri);

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'メールアプリを起動できませんでした';
    }

    // return launch(
    //   _emailLaunchUri.toString(),
    // );
  }
}

bool isOrderDataCompleted(orderData){
    return orderData.store != null
           && orderData.productsInfo.products.isNotEmpty
           && orderData.pay != null
           && orderData.name.text.isNotEmpty
           && orderData.address.text.isNotEmpty;
}
