//this is post screen and in this screen we have large text area with and three buttons one for post one for cancel
// and one for upload image

// ignore: file_names
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            "post the blood donation request",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Color.fromARGB(255, 17, 15, 15).withOpacity(0.1),
                  offset: Offset(5.0, 5.0),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.red.shade200,
        body: Center(
          child: Container(
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: <Widget>[
                    //one text field to upload blood request
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Enter your blood request",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //two buttons for post and cancel
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {},
                          child: Text("Post"),
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                        RaisedButton(
                          onPressed: () {},
                          child: Text("Cancel"),
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                    //one button for upload image
                    RaisedButton(
                      onPressed: () {},
                      child: Text("Upload Image"),
                      color: Colors.red,
                      textColor: Colors.white,
                    ),
                  ]))),
        ));
  }
}
