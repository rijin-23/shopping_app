import 'package:flutter/foundation.dart';

import 'product_info.dart';

class Product_provider with ChangeNotifier {
  List<Product_info> _items = [
    Product_info(
        id: 'p1',
        name: 'Mouse',
        description: 'Gaming Mouse for gamers',
        price: 150,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61fEpBysnmL._AC_SL1280_.jpg'),
    Product_info(
        id: 'p2',
        name: 'Laptop',
        description: 'A laptop for students and professionals',
        price: 1000,
        imageUrl:
            'https://i.gadgets360cdn.com/large/mi_gaming_laptop_2019_image_1565003115644.jpg'),
    Product_info(
        id: 'p3',
        name: 'T-shirt',
        description: 'A laptop for students and professionals',
        price: 30,
        imageUrl:
            'https://tirupurbrands.in/wp-content/uploads/2017/11/Mens-Corporate-T-Shirt-Tirupur-Brands.jpg'),
    Product_info(
        id: 'p4',
        name: 'Bag',
        description: 'A laptop for students and professionals',
        price: 50,
        imageUrl:
            'https://www.smartbranding.top/wp-content/uploads/2019/06/Smart-Branding-Products-Images-Customized-College-Bags-Your-Company-Logo-Here-1.jpg'),
    Product_info(
        id: 'p5',
        name: 'Mug',
        description: 'A laptop for students and professionals',
        price: 15,
        imageUrl:
            'https://www.hometown.in/media/product/93/5553/93824/1-catalog_360.jpg'),
    Product_info(
        id: 'p6',
        name: 'FootBall',
        description: 'A laptop for students and professionals',
        price: 50,
        imageUrl:
            'https://tiimg.tistatic.com/fp/1/006/147/nike-football-856.jpg'),
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

  void addProduct(Product_info product) {
    final _newProduct = Product_info(
      id: DateTime.now().toString(),
      name: product.name,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
    );
    _items.insert(0, _newProduct);
    notifyListeners();
  }

  void deleteItem(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
