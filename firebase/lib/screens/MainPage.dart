import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'dart:typed_data';
import 'dart:ui';

import '../model.dart';
import 'PieceOfFurnitureScreen.dart';
import 'ShoppingCartScreen.dart';
import '../main.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Piece> cartItems = new List<Piece>();

  Widget _buildError(error) {
    return Scaffold(
      body: Center(
        child: Text(
          error.toString(),
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _makeImagesGrid(List<Item> docs, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        backgroundColor: Theme.of(context).appBarTheme.color,
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_alt,
              color: Colors.white,
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: ValueListenableBuilder<String>(
                    valueListenable: orderBy,
                    builder: (context, value, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Filter',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text('Order by: '),
                              _dropDown(),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                  actions: [
                    FlatButton(
                      child: Text('Close'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                );
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShoppingCartScreen(cartItems: cartItems),
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: docs.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          final item = docs[index];
          return ImageGridItem(doc: item, cartItems: cartItems);
        },
      ),
    );
  }

  Widget _dropDown() {
    return DropdownButton<String>(
      value: orderBy.value,
      icon: Icon(Icons.keyboard_arrow_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
      underline: Container(
        height: 2,
        color: Theme.of(context).accentColor,
      ),
      onChanged: (String newValue) {
        setState(() {
          orderBy.value = newValue;
        });
      },
      items: <String>['Name', 'Price']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  ValueNotifier<String> orderBy = ValueNotifier('Name');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: productsListSnapshots(orderBy.value.toLowerCase()),
      builder: (context, AsyncSnapshot<List<Item>> snapshot) {
        if (snapshot.hasError) {
          return _buildError(snapshot.error);
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return _buildLoading();
          case ConnectionState.active:
            return _makeImagesGrid(snapshot.data, context);
          default: // ConnectionState.none || ConnectionState.done
            return _buildError("Unreachable (done or none)");
        }
      },
    );
  }
}

class ImageGridItem extends StatefulWidget {
  String _name;
  String _imageName;
  String _price;
  String _details;
  String _brand;
  num _stars;
  num _valorations;
  List<Piece> cartItems;

  ImageGridItem({Key key, Item doc, this.cartItems}) : super(key: key) {
    this._name = doc.name;
    this._imageName = doc.image;
    this._price = doc.price.toString();
    this._details = doc.details;
    this._brand = doc.brand;
    this._stars = doc.stars;
    this._valorations = doc.valorations;
  }

  @override
  _ImageGridItemState createState() => _ImageGridItemState(cartItems);
}

class _ImageGridItemState extends State<ImageGridItem> {
  final List<Piece> cartItems;
  _ImageGridItemState(this.cartItems);

  Uint8List imageFile;
  Reference photosReference = FirebaseStorage.instance.ref().child('photos');
  Color buttonColor = Colors.white;
  //Piece tempPiece;

  getImage() {
    int MAX_SIZE = 5 * 1024 * 1024;
    photosReference.child(widget._imageName).getData(MAX_SIZE).then((data) {
      this.setState(() {
        imageFile = data;
      });
    }).catchError((error) {});
  }

  Widget decideGridTileWidget() {
    if (imageFile == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Image.memory(
        imageFile,
        fit: BoxFit.contain,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: decideGridTileWidget(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(children: [
                Expanded(
                  flex: 5,
                  child: Text(widget._name),
                ),
                Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Theme.of(context).accentColor,
                      ),
                      child: Center(child: Text('${widget._price}€')),
                    )),
              ]),
            ),
          ],
        ),
        color: buttonColor,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PieceOfFurnitureScreen(
              piece: Piece(
                widget._name,
                widget._details,
                double.parse(widget._price),
                imageFile,
                widget._brand,
                widget._stars,
                widget._valorations,
                [
                  Feature('vruler', '(cm)', "H:107 W:86 D:95"),
                  Feature('weight', 'kg', "19"),
                  Feature('rotation', 'º', "360"),
                  Feature('designed', '', "Arne Jacobsen"),
                ],
                Colors.red,
              ),
            ),
          ),
        ).then((piece) {
          if (piece != null) {
            setState(() {
              this.cartItems.add(piece);
            });
          }
        }),
      ),
    );
  }
}
