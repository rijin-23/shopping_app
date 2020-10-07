import 'package:flutter/material.dart';

class Edit_products extends StatefulWidget {
  @override
  _Edit_productsState createState() => _Edit_productsState();
}

class _Edit_productsState extends State<Edit_products> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add/Edit Products')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  labelStyle: TextStyle(color: Colors.red),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  labelStyle: TextStyle(color: Colors.red),
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  labelStyle: TextStyle(color: Colors.red),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descFocusNode,
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
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          labelStyle: TextStyle(color: Colors.red),
                        ),
                        keyboardType: TextInputType.url,
                        maxLines: 3,
                        focusNode: _imageUrlFocusNode,
                        controller: _imageController,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
