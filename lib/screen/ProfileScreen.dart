import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../imageUpload/showUploadedImage.dart';
import '../imageUpload/uploadImage.dart';
import '../model/user_model.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
   Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body: Center(
         child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child:  Column(
                children: <Widget>[
                  const Text(
                    "Welcome Back",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${loggedInUser.firstName}" "  ${loggedInUser.lastName}",
                  ),
                  Text("${loggedInUser.email}",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                   Text("${loggedInUser.uid}",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      )),
                      const SizedBox(
                    height: 15,
                  ),
                  ActionChip(
                      label: const Text("Logout"),
                      onPressed: () {
                        logout(context);
                      }),
                      //two buttons for upload image and show image
                      const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>uploadImage(userId:loggedInUser.uid!)));
                  }, child: Text("Upload Image"),),
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>showUploadedImage()));
                  }, child: Text("Show Image"),),

                ],
              ),
            ),
          ),
       ),
      
    );
  }
}