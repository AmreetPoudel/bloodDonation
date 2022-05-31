// ignore: file_names
import 'package:blood/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import "package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart";
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: camel_case_types
class allFeedPosts extends StatefulWidget {
  const allFeedPosts({Key? key}) : super(key: key);

  @override
  _allFeedPostsState createState() => _allFeedPostsState();
}

// ignore: camel_case_types
class _allFeedPostsState extends State<allFeedPosts> {
  final Stream<QuerySnapshot> allPost =
      FirebaseFirestore.instance.collection('Post').snapshots();
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
      // ignore: non_constant_identifier_names
      loggedInUser = UserModel.fromMap(value.data()!);
      //after long i found this solution but this does not work for me
      //  loggedInUser  = UserModel.fromMap(value.data().cast<String, dynamic>());

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: allPost,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
            // print('Something went Wrong');
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
            item['uid'] = document.id;
            // print(storedocs);
          }).toList();
          //here we have all items in the list i.e all blood group on bloodgroup and similarly for district post and phone number
          //tried this because if kei add garnu paryo vane simply copy garara thorai change garda hunxa
          List uid = storedocs.map((item) => item['uid']).toList();
          List district = storedocs.map((item) => item['district']).toList();
          List bloodGroup = storedocs.map((i) => i['bloodGroup']).toList();
          List tokenId = storedocs.map((i) => i['tokenId']).toList();
          //finding uid of current logged in user
          loggedInUser.uid = user!.uid;
          loggedInUser.district = loggedInUser.district;
          district.remove(loggedInUser.district);
          uid.remove(loggedInUser.uid);
          List finaltokenId = [];
          // final currentUserUid = loggedInUser.uid;
          for (var i = 0; i < storedocs.length; i++) {
            if (district[i] == loggedInUser.district) {
              if (bloodGroup[i] == loggedInUser.bloodType) {
                finaltokenId.add(tokenId[i]);
              }
            }
          }
          return const MaterialApp();
        });
  }
}
