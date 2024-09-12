import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'resources/order.dart';
import 'router.dart';

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
      child: MaterialApp.router(
        title: 'LatinOne',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: router,
      ),
    );
  }
}
