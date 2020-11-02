import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  void addProduct(List<CartItem> cartProducts, double total) async {
    const url = 'https://shopping-app-ddf3e.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();

    final response = await http.post(
      url,
      body: jsonEncode(
        {
          'amount': total,
          'time': timeStamp.toIso8601String(),
          'order products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'title': e.name,
                    'amount': e.price,
                    'quantity': e.quantity
                  })
              .toList()
        },
      ),
    );
    _products.insert(
      0,
      Orderitem(
          id: jsonDecode(response.body)['name'],
          amount: total,
          dateTime: timeStamp,
          products: cartProducts),
    );
    notifyListeners();
  }
}
