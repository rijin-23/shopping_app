import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String value;
  Badge({this.child, this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Stack(
        children: [
          Center(child: child),
          Positioned(
            top: 5,
            right: 1,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                constraints: BoxConstraints(
                  minWidth: 15,
                  minHeight: 12,
                ),
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
