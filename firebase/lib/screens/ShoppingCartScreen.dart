import 'package:firebase/screens/PaymentScreen.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ShoppingCartScreen extends StatefulWidget {
  final List<Piece> cartItems;
  ShoppingCartScreen({@required this.cartItems});

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sopping Cart'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.black,
                  ),
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        widget.cartItems[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Container(
                        child: Row(
                          children: [
                            Text('1 uds.'),
                          ],
                        ),
                      ),
                      trailing: Text('${widget.cartItems[index].price} €'),
                      onTap: null,
                      onLongPress: () => setState(() =>
                          widget.cartItems.remove(widget.cartItems[index])),
                    );
                  },
                ),
              ),
              Spacer(),
              Row(
                children: [
                  SizedBox(width: 16),
                  Text(
                    'TOTAL: ' + totalPrice(widget.cartItems) + ' €',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(flex: 8, child: _Confirm()),
                ],
              ),
            ],
          ),
        ));
  }
}

class _Confirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[600].withOpacity(0.5),
            blurRadius: 12,
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          height: 60,
          child: Text(
            'Confirm',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}

String totalPrice(List<Piece> cartItems) {
  var i = 0;
  double total = 0;
  while (i < cartItems.length) {
    total += cartItems[i].price;
    i++;
  }
  return total.toString();
}
