import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/provider/order_items.dart';

class Item_Order extends StatefulWidget {
  final Orderitem order;
  Item_Order(this.order);

  @override
  _Item_OrderState createState() => _Item_OrderState();
}

class _Item_OrderState extends State<Item_Order> {
  bool _expand = false;
  @override
  Widget build(BuildContext context) {
    print(widget.order.products.length);
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(children: [
        Container(
          decoration: BoxDecoration(border: Border.all()),
          child: ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle:
                Text(DateFormat('dd/MM/yyyy').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: _expand ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expand = !_expand;
                });
              },
            ),
          ),
        ),
        if (_expand)
          Container(
            decoration: BoxDecoration(border: Border.all()),
            height: min(widget.order.products.length * 20.0 + 10.0, 150),
            child: ListView(
                children: widget.order.products.map((prod) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(prod.name),
                    Text('${prod.quantity}x \$${prod.price}')
                  ],
                ),
              );
            }).toList()),
          )
      ]),
    );
  }
}
