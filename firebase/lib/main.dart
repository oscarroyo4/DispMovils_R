import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'screens/MainPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FirebaseApp());
}

class Feature {
  String icon, units;
  String value;
  Feature(this.icon, this.units, this.value);
}

class Piece {
  String name;
  double price;
  List<Feature> features;
  String details;
  Uint8List photoUrl;
  String brand;
  Color color;
  num stars;
  num numberOfValorations;
  Piece(
    this.name,
    this.details,
    this.price,
    this.photoUrl,
    this.brand,
    this.stars,
    this.numberOfValorations,
    this.features,
    this.color,
  );
}

class FirebaseApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MainPage(),
    );
  }
}
