import 'package:blood/model/user_model.dart';
import 'package:blood/screen/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../imageUpload/uploadImage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Stream<QuerySnapshot> allPost =
      FirebaseFirestore.instance.collection('Post').snapshots();

  final Stream<QuerySnapshot> allimages =
      FirebaseFirestore.instance.collection('Post').snapshots();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  String? get userId => null;

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

      setState(() {});
    });
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
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

          List bloodGroup = storedocs.map((i) => i['bloodGroup']).toList();
          List district = storedocs.map((i) => i['district']).toList();
          List post = storedocs.map((i) => i['post']).toList();
          List phoneNo = storedocs.map((i) => i['phoneNo']).toList();

          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 104, 113, 160),
                      Color.fromARGB(255, 189, 8, 8),
                    ],
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 73),
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.43,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double innerHeight = constraints.maxHeight;
                              double innerWidth = constraints.maxWidth;
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(userId)
                                        .collection("images")
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return (const Center(
                                            child: Text("No Images Found")));
                                      } else {
                                        return ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            String url = snapshot.data!
                                                .docs[index]['downloadURL'];
                                            return Image.network(
                                              url,
                                              height: 300,
                                              fit: BoxFit.fitWidth,
                                            );
                                          },
                                        );
                                      }
                                    },
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
