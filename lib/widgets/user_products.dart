import 'package:flutter/material.dart';

class User_products extends StatelessWidget {
  final String title;
  final String imageUrl;

  User_products(this.title, this.imageUrl);

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
                  onPressed: () {},
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
