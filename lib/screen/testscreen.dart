import 'package:flutter/material.dart';
//create beautiful buttons
class buttondesign extends StatefulWidget {
  const buttondesign({ Key? key }) : super(key: key);

  @override
  State<buttondesign> createState() => _buttondesignState();
}

class _buttondesignState extends State<buttondesign> {
  @override
  Widget build(BuildContext context) {
    final button1=TextButton(
      onPressed: () => {},
      child: const Text('button1'),
    );
    return Container(
      
    );
  }
}