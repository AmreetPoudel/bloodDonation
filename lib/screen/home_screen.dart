import 'package:blood/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'NotificationScreen.dart';
import 'PostScreen.dart';
import 'ProfileScreen.dart';
import 'SearchScreen.dart';
import 'buttonNavigationbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const PostScreen(),
    const NotificationScreen(),
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

  @override
  Widget build(BuildContext context) {
//topmost button inspired from tiktok for the posts from same district
    final forYou = TextButton(
      onPressed: () => {
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
                  children: <Widget>[
                    forYou,
                    allFeed,
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
