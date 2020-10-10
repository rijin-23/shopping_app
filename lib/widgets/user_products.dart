import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class User_products extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  User_products(this.title, this.imageUrl, this.id);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Provider.of<Product_provider>(context, listen: false)
                        .deleteItem(id);
                  },
                  color: Theme.of(context).errorColor,
                )
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
