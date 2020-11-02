import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product_info with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  bool isFav;

  Product_info(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.imageUrl,
      @required this.price,
      this.isFav = false});

  void selectFav() async {
    final fav = isFav;
    isFav = !isFav;
    notifyListeners();
    try {
      var url = 'https://shopping-app-ddf3e.firebaseio.com/products/$id.json';
      final response = await http.patch(
        url,
        body: jsonEncode(
          {'isFav': isFav},
        ),
      );
      if (response.statusCode > 400) {
        isFav = fav;
        notifyListeners();
      }
    } catch (error) {
      isFav = fav;
      notifyListeners();
    }
  }
}
