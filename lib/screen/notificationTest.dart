import 'package:blood/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

// ignore: camel_case_types
class notificationScreen extends StatefulWidget {
  const notificationScreen({Key? key}) : super(key: key);

  @override
  State<notificationScreen> createState() => _notificationScreenState();
}

// ignore: camel_case_types
class _notificationScreenState extends State<notificationScreen> {
  final allPost = FirebaseFirestore.instance.collection('users').snapshots();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data()!);

      setState(() {});
    });
  }

  final allUserLoginCredentials =
      FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference data = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: allPost,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final List storedocs = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map item = document.data() as Map<String, dynamic>;
          storedocs.add(item);
        }).toList();

        List tokenId = storedocs.map((i) => i['tokenId']).toList();
        // List bloodGroup = storedocs.map((i) => i['bloodGroup']).toList();
        // List district = storedocs.map((i) => i['district']).toList();

        void sendnotification() {
          OSCreateNotification(
            playerIds: [tokenId.toString()],
            content: "this is a test from OneSignal's Flutter SDK",
            heading: "Test Notification",

            //we didnot implemented all this functionality because push notification was giving problem
            //test notification is done but from app itself is not happening but i dont know how and why

            // iosAttachments: {"id1": imgUrlString},
            // bigPicture: imgUrlString,
            // buttons: [
            //   OSActionButton(text: "test1", id: "id1"),
            //   OSActionButton(text: "test2", id: "id2")
            // ]
          );

          // var response = await OneSignal.shared.postNotification(notification);
        }

        return Scaffold(
            body: Column(children: <Widget>[
          Text(tokenId.toString()),
          ElevatedButton(
              onPressed: () {
                // setState(() {
                //   sendNotification(tokenId.map((e) => e.toString()).toList(),
                //       "form app  itself", 'kam vayo');
                // });
                sendnotification();
              },
              child: Text("btn"))
        ]));
      },
    );
  }
}

//convert list to list string flutter
// List<String> list = [
//   'one',
//   'two',
//   'three',];