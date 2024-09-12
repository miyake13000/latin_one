import 'package:flutter/material.dart';

var text = ["Order", "Product", "Stores", "Recommend"];
var list = ["IMG_8832.jpg", "IMG_8833.jpg", "IMG_8834.jpg", "IMG_8835.jpg"];

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index){
        return _menuItem(text[index], list[index]);
      },
      separatorBuilder: (BuildContext context, int index){
        return separatorItem();
      },
      itemCount: list.length,
    );
  }

  Widget _menuItem(String text, String imagePath){
    return GestureDetector(
      child:Container(
        height: 300,
        width: 500,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/"+imagePath)),
        ),
        child: Center(
            child: Text(text,
                style: const TextStyle(fontSize: 50)
            )
        )
      ),
      onTap: (){
        null;
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
