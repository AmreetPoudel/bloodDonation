import 'package:flutter/material.dart';

class notificationPage extends StatefulWidget {
  const notificationPage({Key? key}) : super(key: key);

  @override
  State<notificationPage> createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Notification'),
      ),
    );
  }
}
