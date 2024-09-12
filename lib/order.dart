import 'package:flutter/material.dart';

class Order extends ChangeNotifier {
  int? storeId;
  List<(int, int)> products = [];

  Order();

  void changeStore(int id) {
    storeId = id;
  }
}
