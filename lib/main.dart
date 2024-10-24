import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'resources/order.dart';
import 'router.dart';
import 'firebase_options.dart';

void main() async {
  // Initialize Firebase instance
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
