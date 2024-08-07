import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LatinOne',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  var list = ["menu1", "menu2", "menu3", "menu4", "menu5"];

  List<Widget> get _children {
    return [
      ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _messageItem(list[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return separatorItem();
        },
        itemCount: list.length,
      ),
      Center(child: Text('Search')),
      Center(child: Text('Settings')),
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: const Text('LatinOne'),
        backgroundColor: Colors.orange,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.email, color: Colors.white),
            onPressed: null, //TODO:実装
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: null, //TODO:実装
          ),
        ],
      ),
      //Body
      body: _children[_currentIndex],
      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Order',
          ),
        ],
        fixedColor: Colors.blueAccent,
        type: BottomNavigationBarType.fixed,
      ),
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
      decoration: new BoxDecoration(
          border:
              new Border(bottom: BorderSide(width: 0, color: Colors.white))),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 50.0),
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
