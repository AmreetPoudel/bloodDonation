// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class ButtonNavigation extends StatefulWidget {
  const ButtonNavigation({ Key? key }) : super(key: key);

  @override
  State<ButtonNavigation> createState() => _ButtonNavigationState();
}

class _ButtonNavigationState extends State<ButtonNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          backgroundColor: Colors.white,
          elevation: 0.0,
          
          
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(
            color: Colors.red,
          ),
        showUnselectedLabels: false,
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
            label: "send request"
            
            
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