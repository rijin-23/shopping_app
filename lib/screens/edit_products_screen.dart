import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/product_info.dart';
import 'package:shopping_app/provider/product_provider.dart';

class Edit_products extends StatefulWidget {
  @override
  _Edit_productsState createState() => _Edit_productsState();
}

class _Edit_productsState extends State<Edit_products> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _existingProducts = Product_info(
    id: null,
    name: '',
    description: '',
    imageUrl: '',
    price: 0,
  );
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageUrlFocusNode.addListener(_updateImgUrl);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _imageUrlFocusNode.removeListener(_updateImgUrl);
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageController.dispose();
  }

  void _updateImgUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveFormData() {
    final _isValid = _form.currentState.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    Provider.of<Product_provider>(context, listen: false)
        .makePostRequest(_existingProducts)
        .then(
          (_) => Navigator.of(context).pop(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(title: Text('Add/Edit Products')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelStyle: TextStyle(color: Colors.cyan),
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        _existingProducts = Product_info(
                            name: value,
                            id: _existingProducts.id,
                            description: _existingProducts.description,
                            imageUrl: _existingProducts.imageUrl,
                            price: _existingProducts.price);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Plese enter this field';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Price',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelStyle: TextStyle(color: Colors.cyan),
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onSaved: (value) {
                        _existingProducts = Product_info(
                            name: _existingProducts.name,
                            id: _existingProducts.id,
                            description: _existingProducts.description,
                            imageUrl: _existingProducts.imageUrl,
                            price: double.parse(value));
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter this field';
                        } else if (double.tryParse(value) == null) {
                          return 'Please enter a valid amount';
                        } else if (double.parse(value) <= 0) {
                          return 'Please enter a valid amount';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelStyle: TextStyle(color: Colors.cyan),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      focusNode: _descFocusNode,
                      onSaved: (value) {
                        _existingProducts = Product_info(
                            name: _existingProducts.name,
                            id: _existingProducts.id,
                            description: value,
                            imageUrl: _existingProducts.imageUrl,
                            price: _existingProducts.price);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter this field';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 100,
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            child: _imageController.text.isEmpty
                                ? Text('Enter a URL')
                                : FittedBox(
                                    child: Image.network(
                                    _imageController.text,
                                  )),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Image Url',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelStyle: TextStyle(color: Colors.cyan),
                              ),
                              keyboardType: TextInputType.url,
                              maxLines: 3,
                              focusNode: _imageUrlFocusNode,
                              controller: _imageController,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) {
                                _saveFormData();
                              },
                              onSaved: (value) {
                                _existingProducts = Product_info(
                                    name: _existingProducts.name,
                                    id: _existingProducts.id,
                                    description: _existingProducts.description,
                                    imageUrl: value,
                                    price: _existingProducts.price);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter this field';
                                } else if (!value.startsWith('http') ||
                                    !value.startsWith('https')) {
                                  return 'Enter a valid Url';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _saveFormData();
              },
              child: Icon(Icons.save),
            ),
          );
  }
}
