import 'package:flutter/material.dart';

class Drawer_widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.black87),
            child: Center(
                child: Text(
              'Welcome User',
              style: TextStyle(color: Colors.white),
            )),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  trailing: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.of(context).pushNamed('Products_Overview');
                  },
                ),
                ListTile(
                  trailing: Icon(Icons.supervised_user_circle),
                  title: Text('User Products'),
                  onTap: () {
                    Navigator.of(context).pushNamed('User_Products');
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
