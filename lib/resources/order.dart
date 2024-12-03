import 'package:flutter/material.dart';
import '../resources/store.dart';
import '../resources/product.dart';

class Order extends ChangeNotifier {
  Store? store;
  ProductsInfo productsInfo = ProductsInfo([]);
  String? pay;
  var name = TextEditingController();
  var address = TextEditingController();

  void changeStore(Store newStore) {
    store = newStore;
    notifyListeners();
  }

  void changeOrderedProduct(Product product, int quantity) {
    int idx = productsInfo.products.indexWhere((o) => o.product.id == product.id);
    if (idx != -1) {
      if (quantity > 0) {
        productsInfo.products[idx] = OrderedProduct(product, quantity);
      } else {
        productsInfo.products.removeAt(idx);
      }
    } else {
      if (quantity > 0) {
        productsInfo.products.add(OrderedProduct(product, quantity));
      }
    }
    productsInfo.computeAmount();
    notifyListeners();
  }

  int getOrderedProductQuantity(Product product) {
    int idx = productsInfo.products.indexWhere((o) => o.product.id == product.id);
    if (idx == -1) {
      return 0;
    } else {
      return productsInfo.products[idx].quantity;
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

class ProductsInfo {
  List<OrderedProduct> products;
  int amount = 0;

  ProductsInfo(this.products);

  void computeAmount() {
    if (products.isEmpty) {
      amount = 0;
    } else {
      amount = 0;
      for (var product in products) {
        amount = amount + product.product.price * product.quantity;
      }
    }
  }
}