import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/order_items.dart';
import 'package:shopping_app/provider/cart_item.dart';
import 'package:shopping_app/widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartItemProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Your Cart',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, index) {
                    return CartItems(
                      productId: cart.items.keys.toList()[index],
                      amount: cart.items.values.toList()[index].price,
                      id: cart.items.values.toList()[index].id,
                      name: cart.items.values.toList()[index].name,
                      quantity: cart.items.values.toList()[index].quantity,
                    );
                  })),
          Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Amount (Incl taxes)'),
                    Spacer(),
                    Chip(
                      backgroundColor: Colors.black.withOpacity(0.7),
                      label: Text(
                        '\$${cart.totalAmount}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    FlatButton(
                        onPressed: cart.totalAmount == 0
                            ? null
                            : () {
                                Provider.of<Order>(context, listen: false)
                                    .addProduct(
                                  cart.items.values.toList(),
                                  cart.totalAmount,
                                );
                                cart.emptyCart();
                                Navigator.of(context).pushNamed('Order_Screen');
                              },
                        child: Text('Order Now'),)
                  ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          height: 50,
          child: FlatButton(
            color: Colors.black,
            onPressed: () {
              Provider.of<Order>(context, listen: false)
                  .addProduct(cart.items.values.toList(), cart.totalAmount);
              cart.emptyCart();
              Navigator.of(context).pushNamed('Order_Screen');
            },
            child: Text(
              'Order Now',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
