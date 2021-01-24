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
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartItems[index].name),
            subtitle: Text('${cartItems[index].details}'),
            trailing: Text('${cartItems[index].price} €'),
            onTap: null,
            onLongPress: null,
          );
        },
      ),
    );
  }
}