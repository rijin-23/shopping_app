import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping_app/provider/order_items.dart';

import 'package:shopping_app/widgets/item_order.dart';

class Order_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      body: ListView.builder(
          itemCount: orders.products.length,
          itemBuilder: (context, index) {
            return Item_Order(orders.products[index]);
          }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          height: 50,
          child: FlatButton(
            color: Colors.black,
            onPressed: () {},
            child: Text(
              'Continue to payment',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
