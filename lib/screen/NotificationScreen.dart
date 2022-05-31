// ignore: file_names
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class notificationpage extends StatefulWidget {
  const notificationpage({Key? key}) : super(key: key);

  @override
  State<notificationpage> createState() => _notificationpageState();
}

class _notificationpageState extends State<notificationpage> {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final Stream<QuerySnapshot> uidStram =
      FirebaseFirestore.instance.collection('Post').snapshots();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Notification'),
            ),
            body: const Center(
              child: Text('Notification'),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
