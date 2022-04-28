import 'package:blood/screen/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "blood donation app",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const LoginScreen(),
      
    );
  }
}