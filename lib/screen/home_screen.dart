import 'package:blood/model/user_model.dart';
import 'package:blood/screen/allFeedPost.dart';
import 'package:blood/screen/forYouPosts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'NotificationScreen.dart';
import 'PostScreen.dart';
import 'ProfileScreen.dart';
import 'SearchScreen.dart';
import "package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //here we compare the distrit of current user and the district from post(cards) the if both are
  //same we show the cards in for you
  //and for all feed we show all the cards
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  List<Widget> pages = [
    const HomeScreen(),
    const searchPost(),
    const PostScreen(),
    const notificationpage(),
    const ProfileScreen(),
  ];
  // ontap function for button navigation bar
  // defining routes for the bottom navigation bar
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final Stream<QuerySnapshot> allPost =
      FirebaseFirestore.instance.collection('Post').snapshots();
  final Stream<QuerySnapshot> forYouPost =
      FirebaseFirestore.instance.collection('Post').snapshots();
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

          List bloodGroup = storedocs.map((i) => i['bloodGroup']).toList();
          List district = storedocs.map((i) => i['district']).toList();
          List post = storedocs.map((i) => i['post']).toList();
          List phoneNo = storedocs.map((i) => i['phoneNo']).toList();

//topmost button inspired from tiktok for the posts from same district
          final forYou = TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const forYouPosts(),
                ),
              ),
              //posts from same district + notification
            },
            child: const Text(
              'forYou',
              style: TextStyle(fontSize: 15),
            ),
          );
          //topmost button
          final allFeed = TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const allFeedPosts(),
                ),
              ),

              //feed all the posts from users
            },
            child: const Text('allfeed'),
          );
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
