import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


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
    return ListView.separated(
      itemBuilder: (BuildContext context, int index){
        return _menuItem(context, homeitems[index]);
      },
      separatorBuilder: (BuildContext context, int index){
        return separatorItem();
      },
      itemCount: homeitems.length,
    );
  }

  Widget _menuItem(BuildContext context, HomeItem homeitem){
    return GestureDetector(
      child:Container(
        height: 300,
        width: 500,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/${homeitem.imagePath}")),
        ),
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
    );
  }
}
