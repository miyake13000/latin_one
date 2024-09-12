import 'package:flutter/material.dart';

class Order extends ChangeNotifier {
  int? storeId;
  List<OrderedProduct> products = [];

  Order();

  void changeStore(int id) {
    storeId = id;
    notifyListeners();
  }
}

class OrderedProduct {
  final int productId;
  final int quantity;

  OrderedProduct(this.productId, this.quantity);
}
