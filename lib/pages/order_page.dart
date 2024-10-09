import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../resources/order.dart';
import '../resources/store.dart';

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

class OrderForm extends StatefulWidget {
  const OrderForm({super.key});

  @override
  OrderFormState createState() => OrderFormState();
}

class OrderFormState extends State<OrderForm> {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 店舗選択ボタン
        StoreSelectButton(orderData.store),
        const SizedBox(height: 16.0),

        // 店舗表示
        DisplayCurrentStore(store: orderData.store),
        const SizedBox(height: 16.0),

        // 商品選択ボタン
        ProductSelectButton(orderData.products),
        const SizedBox(height: 16.0),

        // 商品表示
        DisplayCurrentProducts(products: orderData.products),
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
          controller: orderData.name,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '氏名',
          ),
        ),
        const SizedBox(height: 16.0),

        // 住所入力
        const Text('住所を入力'),
        TextField(
          controller: orderData.address,
          decoration: const InputDecoration(
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
  final Store? store;

  const StoreSelectButton(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    String text;
    if (store == null) {
      text = '店舗を選択';
    } else {
      text = store!.name;
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
          GoRouter.of(context).push('/store');
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
                        Text('${store!.name}'),
                        Text('${store!.address}')
                      ]
                    )
                ]
            )
          ]
      );
    }
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
          GoRouter.of(context).push('/product');
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

class DisplayCurrentProducts extends StatelessWidget {
  final List<OrderedProduct> products;

  DisplayCurrentProducts({required this.products, super.key});
  int amount=0;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox.shrink();
    } else {
      for(var product in products){
        amount = amount + product.product.price*product.quantity;
      }

      return Column(
        children:[
          const Align(alignment: Alignment.centerLeft,
                child:Text('商品情報',textAlign: TextAlign.left)
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var product in products)
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
                child:Text('合計金額: ¥${amount}')
          )
        ],
      );
    }
  }
}

class PaymentMethodDropdown extends StatefulWidget {
  final List<String> methods;
  final Order? order;

  const PaymentMethodDropdown({super.key, required this.methods, this.order});
  @override
  PaymentMethodDropdownState createState() => PaymentMethodDropdownState();
}

class PaymentMethodDropdownState extends State<PaymentMethodDropdown> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: const Text('選択してください'), // 初期状態のテキスト
      value: selectedItem,
      onChanged: (String? newValue) {
        setState(() {
          selectedItem = newValue;
        });
        widget.order?.changePay(newValue);
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

class SubmitButton extends StatelessWidget {
  final Order orderData;

  const SubmitButton(this.orderData, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // ボタンを横幅いっぱいに広げる
      child: ElevatedButton(
        onPressed:() =>
        {
          if(isOrderDataCompleted(orderData)){
            displayDialog(context, "注文確認画面に遷移したいね．")
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
}

bool isOrderDataCompleted(orderData){
    return orderData.store != null
           && orderData.products.isNotEmpty
           && orderData.pay != null
           && orderData.name.text.isNotEmpty
           && orderData.address.text.isNotEmpty;
}
