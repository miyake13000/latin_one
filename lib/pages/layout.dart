import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // AppBar
      appBar: AppBar(
        title: const Text('LatinOne'),
        backgroundColor: Colors.orange,
        centerTitle: true,
        leading: IconButton(
          icon: (FirebaseAuth.instance.currentUser == null)?
            const Icon(Icons.login):
            const Icon(Icons.account_circle),
          onPressed: (){
              GoRouter.of(context).push('/account');
          },
        ),
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
      body: navigationShell,

      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index) => navigationShell.goBranch(index),
        currentIndex: navigationShell.currentIndex,
        fixedColor: Colors.blueAccent,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Product',
          ),
        ],
      ),
    );
  }
}
