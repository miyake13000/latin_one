import 'package:flutter/material.dart';

var list = ["menu1", "menu2", "menu3", "menu4", "menu5"];

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _messageItem(list[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return separatorItem();
        },
        itemCount: list.length,
      );
  }

  Widget separatorItem() {
    return Container(
      height: 10,
      color: Colors.orange,
    );
  }

  Widget _messageItem(String title) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0, color: Colors.white))
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 50.0),
        ),
        onTap: () {
          null;
        }, // タップ
        onLongPress: () {
          null;
        }, // 長押し
      ),
    );
  }
}
