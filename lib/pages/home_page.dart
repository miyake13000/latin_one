import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_one/resources/product_list.dart';

class HomeItem{
  final String text;
  final String imagePath;
  final String pagePath;

  HomeItem(this.text, this.imagePath, this.pagePath);
}

List<HomeItem> homeitems =
  [HomeItem("Order", "IMG_8832.jpg", "order"),
   HomeItem("Product", "IMG_8833.jpg", "product"),
   HomeItem("Store", "IMG_8834.jpg", "store")
  ];


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        // 広告バナー
        Container(
          height: 100,
          color: Colors.blueAccent,
          child: const Center(
            child: Text(
              '広告バナー',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
<<<<<<< HEAD
        // ListView
        const Expanded(
          child: ProductList(page: false),
        ),
        // 確定ボタン部分
        Container(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // ボタン押下時の処理
                GoRouter.of(context).push('/store');
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 8.0),
                  Icon(
                    Icons.store,
                    size: 40.0,
                  ),
                  Text('店舗選択画面'),
                ],
              )
            ),
          ),
        ),
      ],
||||||| parent of 54bcbb4 (Update login page)
        child: Center(
            child: Text(homeitem.text,
                style: const TextStyle(fontSize: 50)
            )
        )
      ),
      onTap: (){
        GoRouter.of(context).go('/${homeitem.pagePath}',extra: false);
      },
    );
  }

  Widget separatorItem() {
    return Container(
      height: 10,
      color: Colors.white,
=======
        child: Center(
            child: Text(homeitem.text,
                style: const TextStyle(fontSize: 50)
            )
        )
      ),
      onTap: (){
        GoRouter.of(context).push('/${homeitem.pagePath}',extra: false);
      },
    );
  }

  Widget separatorItem() {
    return Container(
      height: 10,
      color: Colors.white,
>>>>>>> 54bcbb4 (Update login page)
    );
  }
}
