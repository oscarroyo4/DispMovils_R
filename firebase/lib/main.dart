import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FirebaseApp());
}

class FirebaseApp extends StatelessWidget {
  // This widget is the root of your application.

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

  Widget _makeImagesGrid(List<Item> docs) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
      ),
      body: GridView.builder(
          itemCount: docs.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            final item = docs[index];
            return ImageGridItem(item);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: StreamBuilder(
        stream: todoListSnapshots(),
        builder: (context, AsyncSnapshot<List<Item>> snapshot) {
          if (snapshot.hasError) {
            return _buildError(snapshot.error);
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return _buildLoading();
            case ConnectionState.active:
              return _makeImagesGrid(snapshot.data);
            default: // ConnectionState.none || ConnectionState.done
              return _buildError("Unreachable (done or none)");
          }
        },
      ),
    );
  }
}

class ImageGridItem extends StatefulWidget {
  String _name;
  String _imageName;
  String _price;

  ImageGridItem(Item doc) {
    this._name = doc.name;
    this._imageName = doc.image;
    this._price = doc.price.toString();
  }

  @override
  _ImageGridItemState createState() => _ImageGridItemState();
}

class _ImageGridItemState extends State<ImageGridItem> {
  Uint8List imageFile;
  Reference photosReference = FirebaseStorage.instance.ref().child('photos');
  Color buttonColor = Colors.white;

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
      return Center(child: Text('no data'));
    } else {
      return Image.memory(
        imageFile,
        fit: BoxFit.fitHeight,
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
              child: decideGridTileWidget(),
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
                        color: Colors.amber,
                      ),
                      child: Center(child: Text('${widget._price}€')),
                    )),
              ]),
            ),
          ],
        ),
        color: buttonColor,
        onPressed: () => print('hello'),
      ),
    );
  }
}
