import 'package:flutter/foundation.dart';

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

  void selectFav() {
    isFav = !isFav;
    notifyListeners();
  }
}
