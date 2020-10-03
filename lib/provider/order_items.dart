import 'package:flutter/cupertino.dart';

import 'cart_item.dart';

class Orderitem {
  final String id;
  final List<CartItem> products;
  final double amount;
  final DateTime dateTime;

  Orderitem({this.id, this.amount, this.dateTime, this.products});
}

class Order with ChangeNotifier {
  List<Orderitem> _products = [];

  List<Orderitem> get products {
    return [..._products];
  }

  void addProduct(List<CartItem> cartProducts, double total) {
    _products.insert(
      0,
      Orderitem(
          id: DateTime.now().toString(),
          amount: total,
          dateTime: DateTime.now(),
          products: cartProducts),
    );
    notifyListeners();
  }
}
