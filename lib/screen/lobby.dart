import 'package:blood/screen/joinwithCode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'joinWithCode.dart' as joinWithCode;
import 'newMeeting.dart';
// import 'package:get/get.dart';

class lobby extends StatelessWidget {
  const lobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          color: Colors.white.withOpacity(0.8),
          height: MediaQuery.of(context).size.height * 0.4,
          child: Center(
            child: Image.asset('assets/blood.jpg'),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewMeeting()),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("New Meeting"),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(350, 30),
              primary: Colors.indigo,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ),
        const Divider(
          thickness: 1,
          height: 40,
          indent: 40,
          endIndent: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JoinWithCode()),
              );
            },
            icon: const Icon(Icons.margin),
            label: const Text("Join with a code"),
            style: OutlinedButton.styleFrom(
              primary: Colors.indigo,
              side: const BorderSide(color: Colors.indigo),
              fixedSize: const Size(350, 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ),
        const SizedBox(height: 150),
      ]),
    );
  }
}
