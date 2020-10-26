import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'product_info.dart';

class Product_provider with ChangeNotifier {
  List<Product_info> _items = [
    // Product_info(
    //     id: 'p1',
    //     name: 'Mouse',
    //     description: 'Gaming Mouse for gamers',
    //     price: 150,
    //     imageUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/61fEpBysnmL._AC_SL1280_.jpg'),
    // Product_info(
    //     id: 'p2',
    //     name: 'Laptop',
    //     description: 'A laptop for students and professionals',
    //     price: 1000,
    //     imageUrl:
    //         'https://i.gadgets360cdn.com/large/mi_gaming_laptop_2019_image_1565003115644.jpg'),
    // Product_info(
    //     id: 'p3',
    //     name: 'T-shirt',
    //     description: 'A laptop for students and professionals',
    //     price: 30,
    //     imageUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/71KGZdTyvtL._UY550_.jpg'),
    // Product_info(
    //     id: 'p4',
    //     name: 'Bag',
    //     description: 'A laptop for students and professionals',
    //     price: 50,
    //     imageUrl:
    //         'https://www.smartbranding.top/wp-content/uploads/2019/06/Smart-Branding-Products-Images-Customized-College-Bags-Your-Company-Logo-Here-1.jpg'),
    // Product_info(
    //     id: 'p5',
    //     name: 'Mug',
    //     description: 'A laptop for students and professionals',
    //     price: 15,
    //     imageUrl:
    //         'https://www.hometown.in/media/product/93/5553/93824/1-catalog_360.jpg'),
    // Product_info(
    //     id: 'p6',
    //     name: 'FootBall',
    //     description: 'A laptop for students and professionals',
    //     price: 50,
    //     imageUrl:
    //         'https://tiimg.tistatic.com/fp/1/006/147/nike-football-856.jpg'),
  ];

  List<Product_info> get items {
    return [..._items];
  }

  List<Product_info> get favitems {
    return _items.where((element) => element.isFav).toList();
  }

  Product_info selectById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> getLatestProducts() async {
    const url = 'https://shopping-app-ddf3e.firebaseio.com/products.json';

    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Product_info> prodFromServer = [];
      extractedData.forEach((key, value) {
        prodFromServer.add(
          Product_info(
              id: key,
              name: value['title'],
              description: value['description'],
              imageUrl: value['imageUrl'],
              price: value['price']),
        );
      });
      _items = prodFromServer;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> makePostRequest(Product_info product) async {
    const url = 'https://shopping-app-ddf3e.firebaseio.com/products.json';
    try {
      final value = await http.post(
        url,
        body: jsonEncode(
          {
            'title': product.name,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFav': product.isFav
          },
        ),
      );
      final _newProduct = Product_info(
        id: jsonDecode(value.body)['name'],
        name: product.name,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
      );
      _items.insert(0, _newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void deleteItem(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
