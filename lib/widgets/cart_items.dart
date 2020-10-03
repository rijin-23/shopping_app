import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/cart_item.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String productId;
  final double amount;
  final String name;
  final int quantity;

  CartItems({this.id, this.amount, this.name, this.quantity, this.productId});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Are you Sure?'),
                content: Text(
                    'Do you wish to remove the selected item from the cart?'),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('Yes'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('No'),
                  )
                ],
              );
            });
      },
      onDismissed: (direction) =>
          Provider.of<CartItemProvider>(context, listen: false)
              .removeItem(productId),
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        margin: const EdgeInsets.all(8),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: Card(
        elevation: 2.0,
        margin: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                  child: Text(
                '${amount.toString()}\$',
                style: TextStyle(color: Colors.white, fontSize: 15),
              )),
            ),
            backgroundColor: Colors.black.withOpacity(0.7),
          ),
          title: Text(name),
          subtitle: Text('Amount:${amount.toString()}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
