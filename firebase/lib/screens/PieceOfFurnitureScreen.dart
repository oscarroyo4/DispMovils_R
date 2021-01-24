import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/color_sample.dart';
import '../widgets/product_feature.dart';

class PieceOfFurnitureScreen extends StatelessWidget {
  final Piece piece;
  PieceOfFurnitureScreen({@required this.piece});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(flex: 4, child: _PiecePreview(piece: piece)),
              Expanded(flex: 6, child: _PieceInfo(piece: piece)),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: _SearchAndCart(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: _PieceColors(color: piece.color),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _SearchAndCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 90,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search),
          SizedBox(width: 20),
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Center(
                child: Icon(Icons.shopping_bag),
              ),
              Align(
                alignment: Alignment(0, -.3),
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).accentColor,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PieceColors extends StatelessWidget {
  final Color color;
  _PieceColors({this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorSample(
              color: Colors.white,
              colorName: 'White',
              selected: color == Colors.white,
            ),
            ColorSample(
              color: Colors.red,
              colorName: 'Red',
              selected: color == Colors.red,
            ),
            ColorSample(
              color: Colors.black,
              colorName: 'Black',
              selected: color == Colors.black,
            )
          ],
        ),
        SizedBox(width: 8),
      ],
    );
  }
}

class _PieceInfo extends StatelessWidget {
  final Piece piece;
  _PieceInfo({this.piece});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 7,
                child: _PieceName(name: piece.name, brand: piece.brand),
              ),
              Expanded(
                flex: 3,
                child: _PiecePrice(price: piece.price),
              ),
            ],
          ),
          _PieceStars(
            stars: piece.stars,
            numOfVal: piece.numberOfValorations,
          ),
          SizedBox(height: 6),
          _PieceDetails(descr: piece.details),
          SizedBox(height: 12),
          _PieceFeatures(features: piece.features),
          Spacer(),
          Row(
            children: [
              Expanded(flex: 8, child: _BuyNow()),
              SizedBox(width: 16),
              Expanded(flex: 2, child: _Favorite(piece: piece)),
            ],
          ),
        ],
      ),
    );
  }
}

class _PiecePrice extends StatelessWidget {
  final double price;
  _PiecePrice({this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$$price',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        fontSize: 18,
      ),
      textAlign: TextAlign.end,
    );
  }
}

class _PieceFeatures extends StatelessWidget {
  final List<Feature> features;
  _PieceFeatures({this.features});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Wrap(
          spacing: 16,
          children: [
            for (var feature in features)
              ProductFeature(
                iconName: feature.icon,
                units: feature.units,
                value: feature.value,
              ),
          ],
        ),
      ),
    );
  }
}

class _PieceDetails extends StatelessWidget {
  final String descr;
  _PieceDetails({this.descr});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          descr,
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.grey[700],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _PieceName extends StatelessWidget {
  final String name;
  final String brand;
  _PieceName({this.name, this.brand});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            brand,
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Roboto',
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}

class _PieceStars extends StatelessWidget {
  final num stars;
  final num numOfVal;
  _PieceStars({this.stars, this.numOfVal});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var i = 0; i < 6; i++)
            if (i < stars)
              Icon(Icons.star, size: 20, color: Colors.amber)
            else if (i < 5)
              Icon(Icons.star,
                  size: 20, color: Theme.of(context).backgroundColor)
            else
              Center(
                child: Text(
                  ' ($numOfVal)',
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontSize: 13,
                    fontFamily: 'Roboto',
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
        ],
      ),
    );
  }
}

class _PiecePreview extends StatelessWidget {
  final Piece piece;
  _PiecePreview({@required this.piece});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: _PiecePhoto(asset: piece.photoUrl),
    );
  }
}

class _PiecePhoto extends StatelessWidget {
  final Uint8List asset;
  _PiecePhoto({this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 180,
      alignment: Alignment.bottomCenter,
      child: setImageWidget(asset),
    );
  }
}

Widget setImageWidget(Uint8List imageFile) {
  if (imageFile == null) {
    return Center(child: CircularProgressIndicator());
  } else {
    return Image.memory(
      imageFile,
      fit: BoxFit.contain,
    );
  }
}

class _BuyNow extends StatelessWidget {
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
        onTap: () {
          //Favorite pressed
        },
        child: Container(
          alignment: Alignment.center,
          height: 60,
          child: Text(
            'Buy Now',
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

class _Favorite extends StatelessWidget {
  final Piece piece;
  _Favorite({this.piece});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Theme.of(context).buttonTheme.colorScheme.secondary,
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
        onTap: () {
          Navigator.pop(context, piece);
        },
        child: Container(
          alignment: Alignment.center,
          height: 60,
          child: Icon(
            Icons.add_shopping_cart,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
    );
  }
}
