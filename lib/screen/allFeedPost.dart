// ignore: file_names
import 'package:blood/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import "package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: camel_case_types
class allFeedPosts extends StatefulWidget {
  const allFeedPosts({Key? key}) : super(key: key);

  @override
  _allFeedPostsState createState() => _allFeedPostsState();
}

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

  // // For Deleting User..............................................................................................
  // CollectionReference posts =
  //     FirebaseFirestore.instance.collection('Post');
  // Future<void> deleteUser(id) {
  //   // print("User Deleted $id");
  //   return students
  //       .doc(id)
  //       .delete()
  //       .then((value) => print('User Deleted'))
  //       .catchError((error) => print('Failed to Delete user: $error'));
  // }

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

          List bloodGroup = storedocs.map((i) => i['bloodGroup']).toList();
          List district = storedocs.map((i) => i['district']).toList();
          List post = storedocs.map((i) => i['post']).toList();
          List phoneNo = storedocs.map((i) => i['phoneNo']).toList();
          return SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    for (var i = 0; i < storedocs.length; i++)

                      // ignore: sized_box_for_whitespace
                      Container(
                        width: double.infinity,
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 11.0),
                          elevation: 7,
                          shadowColor: Colors.red,
                          borderOnForeground: true,
                          // width: double.infinity,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            textDirection: TextDirection.rtl,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                'blood group: ${bloodGroup[i]}',
                                style: TextStyle(
                                  color: Colors.red.shade500,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'district: ${district[i]}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'request: ${post[i]}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'phone Number: ${phoneNo[i]}',
                                    style: TextStyle(
                                      color: Colors.red.shade500,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  //icon to call the number
                                  // IconButton(onPressed: ()async{
                                  //   launch('tel:${phoneNo[i]}');
                                  // }, icon: Icon(Icons.call), color: Colors.red.shade500,),
                                  //this process doesnt worked so tried this one
                                  const SizedBox(width: 75),
                                  // ElevatedButton(
                                  //     onPressed: () async {
                                  //
                                  //     },
                                  //     child:
                                  IconButton(
                                      icon: const FaIcon(
                                        FontAwesomeIcons.phone,
                                        color: Colors.lightBlueAccent,
                                      ),
                                      onPressed: () async {
                                        await FlutterPhoneDirectCaller
                                            .callNumber(phoneNo[i]);
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
