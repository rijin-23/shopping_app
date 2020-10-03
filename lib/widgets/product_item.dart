import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_item.dart';
import 'package:shopping_app/provider/product_info.dart';

class Product_item extends StatelessWidget {
  final int index;

  Product_item({this.index});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product_info>(context, listen: false);
    final cartItem = Provider.of<CartItemProvider>(context, listen: false);
    print('rebuilt');
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed('Page_description', arguments: product.id);
          },
          child: Hero(
            tag: 'product_image' + index.toString(),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(product.name),
          leading: Consumer<Product_info>(
            builder: (ctx, product, child) {
              return IconButton(
                  icon: Icon(
                    product.isFav ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    product.selectFav();
                  });
            },
          ),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cartItem.addItem(product.id, product.price, product.name);
              }),
        ),
      ),
    );
  }
}
