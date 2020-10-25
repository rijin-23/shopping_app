import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping_app/provider/cart_item.dart';
import 'package:shopping_app/provider/product_provider.dart';
import 'package:shopping_app/widgets/drawer_widget.dart';

import '../widgets/badge.dart';

import '../widgets/product_item.dart';

enum Selection { Favorites, All }

class Products_Overview extends StatefulWidget {
  @override
  _Products_OverviewState createState() => _Products_OverviewState();
}

class _Products_OverviewState extends State<Products_Overview> {
  var _showSelected = false;

  bool _isInit = true;

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Product_provider>(context).getLatestProducts().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping App'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favorites'),
                value: Selection.Favorites,
              ),
              PopupMenuItem(child: Text('All'), value: Selection.All)
            ],
            icon: Icon(Icons.more_vert),
            onSelected: (Selection filter) {
              setState(() {
                if (filter == Selection.Favorites) {
                  _showSelected = true;
                } else {
                  _showSelected = false;
                }
              });
            },
          ),
          Consumer<CartItemProvider>(
            builder: (_, cart, ch) {
              return Badge(
                child: ch,
                value: cart.cartItems.toString(),
              );
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed('Cart_Screen');
              },
            ),
          )
        ],
      ),
      drawer: Drawer_widget(),
      body: _isLoading
          ? Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Fetching Data...')
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Product_grid(_showSelected),
            ),
    );
  }
}

class Product_grid extends StatelessWidget {
  final bool selection;

  Product_grid(this.selection);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Product_provider>(context);

    final productItems =
        selection ? productProvider.favitems : productProvider.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        //childAspectRatio: 3 / 2
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: productItems[index],
          child: Product_item(
            index: index,
          ),
        );
      },
      itemCount: productItems.length,
    );
  }
}
