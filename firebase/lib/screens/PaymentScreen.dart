import 'package:flutter/material.dart';

import '../main.dart';

class PaymentScreen extends StatefulWidget {
  //final Dish dish;
  final String title;
  PaymentScreen({
    //@required this.dish,
    this.title = "Datos de Pago",
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController _namecontroller;
  TextEditingController _adresscontroller;
  TextEditingController _postcodecontroller;
  TextEditingController _creditcardnumbercontroller;
  TextEditingController _expirationdatecontroller;
  TextEditingController _cvvcontroller;
  @override
  void initState() {
    _namecontroller = TextEditingController(
      text: '',
    );
    _adresscontroller = TextEditingController(
      text: '',
    );
    _postcodecontroller = TextEditingController(
      text: '',
    );
    _creditcardnumbercontroller = TextEditingController(
      text: '',
    );
    _expirationdatecontroller = TextEditingController(
      text: '',
    );
    _cvvcontroller = TextEditingController(
      text: '',
    );
    super.initState();
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<String> plato = ['Primero', 'Segundo', 'Postre'];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Name and surname",),
            TextField(
              controller: _namecontroller,
            ),
            SizedBox(height: 16),
            Text("Adress"),
            TextField(
              controller: _adresscontroller,
            ),
            SizedBox(height: 16),
            Text("Postcode"),
            TextField(
              keyboardType: TextInputType.number,
              controller: _postcodecontroller,
            ),
             SizedBox(height: 80),
            Text("Credit Card Number"),
            TextField(
              keyboardType: TextInputType.number,
              controller: _creditcardnumbercontroller,
            ),
            SizedBox(height: 16),
            Text("Expiration Date"),
            TextField(
              keyboardType: TextInputType.number,
              controller: _expirationdatecontroller,
            ),
            SizedBox(height: 16),
            Text("CVV"),
            TextField(
              keyboardType: TextInputType.number,
              controller: _cvvcontroller,
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                child: Text(
            'Accept',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 25,
            ),
          ),
                onPressed: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}