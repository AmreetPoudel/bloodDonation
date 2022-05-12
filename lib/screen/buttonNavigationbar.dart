// ignore_for_file: camel_case_types

import 'package:blood/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'NotificationScreen.dart';
import 'PostScreen.dart';
import 'ProfileScreen.dart';
import 'SearchScreen.dart';

class ButtonNavigation extends StatefulWidget {
  const ButtonNavigation({ Key? key }) : super(key: key);

  @override
  State<ButtonNavigation> createState() => _ButtonNavigationState();
}

class _ButtonNavigationState extends State<ButtonNavigation> {
  //pages list for the bottom navigation bar
  List pages = [
    const HomeScreen(),
    const SearchScreen(),
    const PostScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
  //ontap function for button navigation bar
  //defining routes for the bottom navigation bar
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          //selectedItemColor: Colors.red,
          backgroundColor: Colors.white,
          elevation: 0.0, 
          onTap: onTap,
          currentIndex: currentIndex,
          //unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(
           // color: Colors.red,
          ),
        showUnselectedLabels: false,
        showSelectedLabels: true,
          selectedFontSize: 15,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,),
          type: BottomNavigationBarType.fixed,
          items: [
          BottomNavigationBarItem(
            icon:  Icon(Icons.apps,
            size: 25 ,),
            label: 'Home',
          ),
          
        BottomNavigationBarItem(
            icon: Icon(Icons.search,
            size: 25 ,),
            label: 'search',
          ),
       
           BottomNavigationBarItem(
            icon:  Icon(Icons.add,
            size: 40 ,
            ),
            label: "Request"
            
            
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.circle_notifications,
            size: 25 ,),
            label: 'notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,size: 25,),
            label: 'profile',
          ),
      ],
        )
      
    );
  }
}