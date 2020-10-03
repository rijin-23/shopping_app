import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping_app/provider/product_provider.dart';

class Page_description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments;
    final products = Provider.of<Product_provider>(context, listen: false)
        .selectById(productId);
    return Scaffold(
      appBar: AppBar(title: Text(products.name)),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 300,
            width: double.infinity,
            child: Column(
              children: [
                Hero(
                    tag: 'product_image',
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2)),
                      child: Image.network(
                        products.imageUrl,
                        height: 250,
                        width: 250,
                        fit: BoxFit.contain,
                      ),
                    )),
                SizedBox(height: 20),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Column(
              children: [
                Text(
                  'Product Description',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(products.description)
              ],
            ),
          )
        ],
      ),
    );
  }
}
