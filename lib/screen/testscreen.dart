// ignore_for_file: prefer_const_constructors
import '/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, String? title}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    return Scaffold(
      body: Column(
        children: [
          Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.cover,
                  image: const AssetImage('assets/blood.jpg'),
                ),
                Positioned(
                    bottom: -50.0,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 77,
                        backgroundImage: const AssetImage('assets/blood.jpg'),
                        child: Align(
                            alignment: Alignment(2, 0.9),
                            child: RawMaterialButton(
                              onPressed: () {},
                              elevation: 2.0,
                              fillColor: Colors.black,
                              child: Icon(
                                Icons.camera_alt,
                                size: 15.0,
                              ),
                              padding: EdgeInsets.all(11.0),
                              shape: CircleBorder(),
                            )),
                        //add camera button on circlar avatar to change profile picture
                      ),
                    ))
              ]),
          SizedBox(
            height: 45,
          ),
          ListTile(
            title: Center(
                child:
                    Text('${loggedInUser.firstName} ${loggedInUser.lastName}')),
            subtitle: Center(child: Text('${loggedInUser.email}')),
          ),
          ListTile(
            title: Text('About me '),
            subtitle: Text(
                'Iheb Meftah ,étudiant en Licence Science Inforamtiques specialite Anlayse De Donnees et Big Data  '),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text('Education'),
            subtitle: Text(
                'Higher Institute of Computer Science and Multimedia of Sfax '),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text('Social'),
            subtitle: Row(
              children: [
                Expanded(
                  child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                      ),
                      onPressed: () {}),
                ),
                Expanded(
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.linkedin),
                      onPressed: () {}),
                ),
                Expanded(
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.facebook),
                      onPressed: () {}),
                ),
                Expanded(
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.instagram),
                      onPressed: () {}),
                ),
              ],
            ),
          ),
//user details with edit items data fetched from firebase also with edit button
        ],
      ),
    );
  }
}
