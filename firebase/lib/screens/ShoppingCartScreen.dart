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
      body: Column(
        children: [
          Expanded(
            flex: 9,
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cartItems[index].name),
                subtitle: Text('1 uds.'),
                trailing: Text('${cartItems[index].price} €'),
                onTap: null,
                onLongPress: null,
              );
            },
          ),
          ),
          Expanded(
            flex: 1,
          child: Text('TOTAL: ' +totalPrice(cartItems)+ ' €'),
          ),
          
        ],
      ),
    );
  }
}

String totalPrice(List<Piece> cartItems){
  var i = 0;
  double total = 0;
  while (i<cartItems.length) {
    total += cartItems[i].price;
    i++;
  }

  return total.toString();
}