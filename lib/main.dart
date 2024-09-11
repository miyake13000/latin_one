import 'package:flutter/material.dart';
import 'main_page.dart';
import 'order_page.dart';
import 'store_page.dart';

enum SelectedScreen {
  main(0),
  store(1),
  order(2);

  const SelectedScreen(this.value);
  final int value;
}

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LatinOne',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int screenIndex = 0;

  void handleScreenChanged(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  Widget createScreen(SelectedScreen selectedScreen) {
    switch (selectedScreen) {
      case SelectedScreen.main:
        return const MainPage();
      case SelectedScreen.store:
        return const StorePage();
      case SelectedScreen.order:
        return const OrderPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('LatinOne'),
        backgroundColor: Colors.orange,
        centerTitle: true,
        actions: const <Widget>[
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
      body: createScreen(SelectedScreen.values[screenIndex]),

      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            screenIndex = index;
            handleScreenChanged(screenIndex);
          });
        },
        currentIndex: screenIndex,
        items: const <BottomNavigationBarItem>[
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
}
