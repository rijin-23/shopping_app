import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String name;
  final int quantity;
  final double price;

  CartItem({this.id, this.name, this.quantity, this.price});
}

class CartItemProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.quantity * value.price;
    });
    return total;
  }

  int get cartItems {
    return _items.length;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              name: value.name,
              price: value.price,
              quantity: value.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () =>
              CartItem(id: productId, price: price, name: title, quantity: 1),);
      print('Product added');
      print(_items.length);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void emptyCart() {
    _items = {};
    notifyListeners();
  }
}
