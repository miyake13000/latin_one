import 'package:flutter/material.dart';
import 'main_page.dart';
import 'order_page.dart';
import 'store_page.dart';

enum SelectedScreen {
  main(0),
  store(1),
  order(2);

  const SelectedScreen(this.value);
  final int value;

  Widget create() {
    switch (this) {
      case SelectedScreen.main:
        return const MainPage();
      case SelectedScreen.store:
        return const StorePage();
      case SelectedScreen.order:
        return const OrderPage();
    }
  }
}
