import 'package:blood/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
//topmost button inspired from tiktok for the posts from same district
  final forYou=TextButton(
    
      onPressed: () => {
        //posts from same district + notification
      },
      child: const Text('forYou' ,style: TextStyle(fontSize: 15
      ),),
     
    );
    //topmost button 
    final allFeed=TextButton(
      onPressed: () => {
        //feed all the posts from users
      },
      child: const Text('allfeed'),
    );
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("blood donation"),
        //   centerTitle: true,
        // ),
        body: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[forYou, allFeed, ]),
            SizedBox(
              height: 150,
              child: Image.asset(
                "assets/blood.jpg",
                fit: BoxFit.contain,
              ),
            ),
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
            ActionChip(
                label: const Text("Logout"),
                onPressed: () {
                  logout(context);
                }),
          ],
        ),
      ),
    ),
    //designing button navigation items using bottomnavigationbar
 bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
          BottomNavigationBarItem(
            icon:  Icon(Icons.apps),
            label: 'Home',
          ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
       
          
           BottomNavigationBarItem(
            icon: Icon(Icons.circle_notifications),
            label: 'notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'person',
          ),
      ],
        )

    );
  }

  //logout for chip logout
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
