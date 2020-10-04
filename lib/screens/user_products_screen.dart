import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/widgets/drawer_widget.dart';
import 'package:shopping_app/widgets/user_products.dart';

import '../provider/product_provider.dart';

class User_products_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Product_provider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Products'),
      ),
      drawer: Drawer_widget(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Expanded(
          child: ListView.builder(
              itemCount: productsData.items.length,
              itemBuilder: (_, index) {
                return User_products(productsData.items[index].name,
                    productsData.items[index].imageUrl);
              }),
        ),
      ),
    );
  }
}
