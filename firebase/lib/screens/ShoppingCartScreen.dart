import 'package:flutter/material.dart';

import '../main.dart';


class ShoppingCartScreen extends StatelessWidget {
  final List<Piece> cartItems;
  ShoppingCartScreen({@required this.cartItems});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sopping Cart'),
      ),
      body: Text(cartItems[0].name),
    );
  }
}