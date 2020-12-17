import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FirebaseApp());
}

class FirebaseApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(title: Text('DM Frontend')),
      body: StreamBuilder(
        stream: db
            .collection('users')
            .where('age', isGreaterThan: 20)
            .orderBy('age', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final query = snapshot.data;
          final documents = query.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final user = documents[index];
              return ListTile(
                title: Text('${user['first_name']} ${user['last_name']}'),
                subtitle: Text('${user['age']}'),
              );
            },
          );
        },
      ),
    );
  }
}
