import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/order.dart';
import '../models/store.dart';
import '../models/product.dart';

class OrderController extends Notifier<Order> {
  @override
  Order build() {
    return Order();
  }

  void changeStore(Store newStore) {
    state.store = newStore;
  }

  void changeProduct(Product product, int quantity) {
    int idx = state.products.indexWhere((o) => o.product.id == product.id);
    if (idx != -1) {
      if (quantity > 0) {
        state.products[idx] = OrderedProduct(product, quantity);
      } else {
        state.products.removeAt(idx);
      }
    } else {
      if (quantity > 0) {
        state.products.add(OrderedProduct(product, quantity));
      }
    }
  }

  void changePay(String pay){
    state.pay = pay;
  }

  void changeName(String name){
    state.name = name;
  }

  void changeAddress(String address){
    state.address = address;
  }
}
