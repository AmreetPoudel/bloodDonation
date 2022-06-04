import 'package:blood/model/user_model.dart';
import 'package:blood/screen/login_screen.dart';
import 'package:blood/screen/updatedetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'updatedetails.dart';

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
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                child: const Icon(
                                  AntDesign.logout,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  logout(context);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                child: const Icon(
                                  AntDesign.setting,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Updateuser(
                                        id: user!.uid,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'My\nProfile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontFamily: 'Nisebuschgardens',
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Container(
                          height: height * 0.43,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double innerHeight = constraints.maxHeight;
                              double innerWidth = constraints.maxWidth;
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: innerHeight * 0.72,
                                      width: innerWidth,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: const Color.fromARGB(
                                            255, 221, 214, 214),
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 80,
                                          ),
                                          Text(
                                            '${loggedInUser.firstName} ${loggedInUser.lastName}',
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  39, 105, 171, 1),
                                              fontFamily: 'Nunito',
                                              fontSize: 37,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${loggedInUser.email}',
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  39, 105, 171, 1),
                                              fontFamily: 'Nunito',
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'District',
                                                    style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontFamily: 'Nunito',
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${loggedInUser.district}',
                                                    style: TextStyle(
                                                      color:
                                                          const Color.fromRGBO(
                                                              39, 105, 171, 1),
                                                      fontFamily: 'Nunito',
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.05,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 25,
                                                  vertical: 8,
                                                ),
                                                child: Container(
                                                  height: 50,
                                                  width: 3,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'blood group',
                                                    style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontFamily: 'Nunito',
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.05,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${loggedInUser.bloodType}',
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          39, 105, 171, 1),
                                                      fontFamily: 'Nunito',
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  //
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(loggedInUser.uid)
                                        .collection("images")
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Positioned(
                                          bottom: 160.0,
                                          left: 0,
                                          right: 0,
                                          child: Center(
                                            child: _NoImageWidget(
                                                loggedInUser: loggedInUser),
                                          ),
                                        );
                                      } else {
                                        final hasImage =
                                            snapshot.data?.docs.isNotEmpty;

                                        // String url = snapshot.data!
                                        //     .docs[index]['downloadURL'];

                                        if (hasImage ?? false) {
                                          final url = snapshot.data!.docs.first
                                              .get('downloadURL');

                                          return Positioned(
                                            bottom: 150.0,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.28,
                                            child: CircleAvatar(
                                              radius: 70,
                                              backgroundColor:
                                                  Colors.blueGrey[600],
                                              child: CircleAvatar(
                                                radius: 67,
                                                backgroundImage:
                                                    NetworkImage(url),
                                                child: const Align(
                                                  alignment: Alignment(2, 0.9),
                                                ),
                                              ),
                                            ),
                                          );
                                        }

                                        return Positioned(
                                          bottom: 160.0,
                                          left: 0,
                                          right: 0,
                                          child: Center(
                                            child: _NoImageWidget(
                                                loggedInUser: loggedInUser),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          // height: height * 0.3,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'requests for me',
                                  style: TextStyle(
                                    color: Color.fromRGBO(39, 105, 171, 1),
                                    fontSize: 27,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                                const Divider(
                                  thickness: 2.5,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    for (var i = 0; i < storedocs.length; i++)
                                      if (district[i] == loggedInUser.district)
                                        // ignore: sized_box_for_whitespace
                                        Container(
                                          width: double.infinity,
                                          child: Card(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5.0,
                                                vertical: 15.0),
                                            elevation: 7,
                                            shadowColor: Colors.red,
                                            borderOnForeground: true,
                                            // width: double.infinity,
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Column(
                                              textDirection: TextDirection.rtl,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
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
                                                        color:
                                                            Colors.red.shade500,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 0),
                                                    IconButton(
                                                        icon: const FaIcon(
                                                          FontAwesomeIcons
                                                              .phone,
                                                          color: Colors
                                                              .lightBlueAccent,
                                                        ),
                                                        onPressed: () async {
                                                          await FlutterPhoneDirectCaller
                                                              .callNumber(
                                                                  phoneNo[i]);
                                                        }),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
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

class _NoImageWidget extends StatelessWidget {
  const _NoImageWidget({
    Key? key,
    required this.loggedInUser,
  }) : super(key: key);

  final UserModel loggedInUser;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 70,
      backgroundColor: Colors.blueGrey[600],
      child: CircleAvatar(
        radius: 67,
        backgroundImage: const AssetImage('assets/blood.jpg'),
        child: Align(
            alignment: const Alignment(2, 0.9),
            child: RawMaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageUpload(userId: loggedInUser.uid),
                  ),
                );
              },
              elevation: 2.0,
              fillColor: Colors.blueGrey[600],
              child: const Icon(
                Icons.camera_alt,
                size: 15.0,
              ),
              padding: const EdgeInsets.all(11.0),
              shape: const CircleBorder(),
            )),
        //add camera button on circlar avatar to change profile picture
      ),
    );
  }
}
