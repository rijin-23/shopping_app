import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/auth.dart';
import 'package:shopping_app/screens/auth_screen.dart';
import 'package:shopping_app/screens/edit_products_screen.dart';
import 'package:shopping_app/screens/order_screen.dart';
import 'package:shopping_app/screens/user_products_screen.dart';
//import 'package:shopping_app/widgets/user_products.dart';

import './provider/product_provider.dart';
import './provider/order_items.dart';
import './screens/cart_screen.dart';
import './provider/cart_item.dart';
import './screens/products_overview_screen.dart';
import './screens/page_description_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Product_provider(),
        ),
        ChangeNotifierProvider.value(
          value: CartItemProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Order(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: AuthScreen(),
        routes: {
          'Products_Overview': (context) => Products_Overview(),
          'Page_description': (context) => Page_description(),
          'Cart_Screen': (context) => CartScreen(),
          'Order_Screen': (context) => Order_Screen(),
          'User_Products': (context) => User_products_screen(),
          'Edit_products': (context) => Edit_products()
        },
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
