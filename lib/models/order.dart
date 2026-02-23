import 'package:flutter/material.dart';
import '../models/store.dart';
import '../models/product.dart';

class Order extends ChangeNotifier {
  Store? store;
  List<OrderedProduct> products = [];
  String? pay;
  String? name;
  String? address;

  int getQuantity(Product product) {
    int idx = products.indexWhere((o) => o.product.id == product.id);
    if (idx == -1) {
      return 0;
    } else {
      return products[idx].quantity;
    }
  }

  int ammount() {
    int sum = 0;
    for (var p in products) {
      sum += p.product.price * p.quantity;
    }
    return sum;
  }
}

class OrderedProduct {
  final Product product;
  final int quantity;

  OrderedProduct(this.product, this.quantity);
}

