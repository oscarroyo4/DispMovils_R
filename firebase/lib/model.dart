import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String id;
  String name;
  num price;
  String image;

  Item.fromFirestore(DocumentSnapshot doc) {
    this.id = doc.id;
    this.name = doc['name'];
    this.price = doc['price'];
    this.image = doc['image'];
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'price': price,
        'image': image,
      };
}

Stream<List<Item>> productsListSnapshots(String orderBy) {
  final products = FirebaseFirestore.instance.collection('products');
  return products.orderBy(orderBy).snapshots().map((QuerySnapshot query) {
    List<Item> result = [];
    for (var doc in query.docs) {
      result.add(Item.fromFirestore(doc));
    }
    return result;
  });
}
