import 'package:firebase/screens/MainPage.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class PaymentScreen extends StatefulWidget {
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
    _adresscontroller.dispose();
    _postcodecontroller.dispose();
    _creditcardnumbercontroller.dispose();
    _expirationdatecontroller.dispose();
    _cvvcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Datos de Pago"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            "Name and surname",
          ),
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
          _Accept(),
        ],
      ),
    );
  }
}

class _Accept extends StatelessWidget {
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
            builder: (context) => MainPage(),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: 200,
          child: Text(
            'Accept',
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
