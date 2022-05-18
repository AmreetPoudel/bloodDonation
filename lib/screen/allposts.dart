import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class allPosts extends StatefulWidget {
  allPosts({Key? key}) : super(key: key);

  @override
  _allPostsState createState() => _allPostsState();
}

class _allPostsState extends State<allPosts> {
  final Stream<QuerySnapshot> allPost =
      FirebaseFirestore.instance.collection('Post').snapshots();

  // // For Deleting User..............................................................................................
  // CollectionReference students =
  //     FirebaseFirestore.instance.collection('students');
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map item = document.data() as Map<String, dynamic>;
            storedocs.add(item);
            item['uid'] = document.id;
            print(storedocs);
          }).toList();

          List bloodGroup = storedocs.map((i) => i['bloodGroup']).toList();
          List district = storedocs.map((i) => i['district']).toList();
          List Post = storedocs.map((i) => i['post']).toList();
          return SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    //card to display bloodgroup, district and blood request
                    //for loop
                    // for (var i = 0; i < storedocs.length; i++) {
                    // for(var);
                    // for loop to display all the posts in card
                    for (var i = 0; i < storedocs.length; i++)
                      Container(
                        width: double.infinity,
                        child: Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
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
                                'blood group: ${storedocs.map((i) => i['bloodGroup']).toList()[i]}',
                                style: TextStyle(
                                  color: Colors.red.shade500,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'district: ${storedocs.map((i) => i['district']).toList()[i]}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'request: ${storedocs.map((i) => i['post']).toList()[i]}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
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
