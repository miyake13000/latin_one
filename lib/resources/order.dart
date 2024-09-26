import 'package:flutter/material.dart';
import '../resources/store.dart';
import '../resources/product.dart';

class Order extends ChangeNotifier {
  Store? store;
  List<OrderedProduct> products = [];
  String? pay;
  var name = TextEditingController();
  var address = TextEditingController();

  void changeStore(Store newStore) {
    store = newStore;
    notifyListeners();
  }

  void changeOrderedProduct(Product product, int quantity) {
    int idx = products.indexWhere((o) => o.product.id == product.id);
    if (idx == -1) {
      products.add(OrderedProduct(product, quantity));
    } else {
      products[idx] = OrderedProduct(product, quantity);
    }
    notifyListeners();
  }

int getOrderedProductQuantity(Product product) {
    int idx = products.indexWhere((o) => o.product.id == product.id);
    if (idx == -1) {
      return 0;
    } else {
      return products[idx].quantity;
    }
}

  void changePay(String? item){
    pay = item;
    notifyListeners();
  }
}

class OrderedProduct {
  final Product product;
  final int quantity;

  OrderedProduct(this.product, this.quantity);
}
