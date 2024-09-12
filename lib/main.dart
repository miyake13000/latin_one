import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order.dart';
import 'home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});
  final Order orderData = Order();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Order>(
      create: (context) => Order(),
      child: MaterialApp(
        title: 'LatinOne',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home(),
      ),
    );
  }
}
