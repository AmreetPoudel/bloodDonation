import 'dart:convert';
import 'dart:async';
import 'package:blood/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class notificationScreen extends StatefulWidget {
  const notificationScreen({Key? key}) : super(key: key);

  @override
  State<notificationScreen> createState() => _notificationScreenState();
}

class _notificationScreenState extends State<notificationScreen> {
  Future<Response> sendNotification(
      List<String> tokenIdList, String contents, String heading) async {
    return await http.post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "app_id":
            "6c6a3a20-d3a7-4dea-b5ab-e4a47e61016d", //kAppId is the App Id that one get from the OneSignal When the application is registered.

        "include_player_ids":
            tokenIdList, //tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

        // android_accent_color reprsent the color of the heading text in the notifiction
        "android_accent_color": "FF9976D2",

        "small_icon": "ic_stat_onesignal_default",

        "large_icon":
            "data:image/jpeg;base64,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",

        "headings": {"en": heading},

        "contents": {"en": contents},
      }),
    );
  }

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

        return Scaffold(
            body: Column(children: <Widget>[
          Text(tokenId.toString()),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  sendNotification(tokenId.map((e) => e.toString()).toList(),
                      "form app  itself", 'kam vayo');
                });
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