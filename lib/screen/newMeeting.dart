import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';
import 'videocall.dart';

class NewMeeting extends StatefulWidget {
  NewMeeting({Key? key}) : super(key: key);

  @override
  _NewMeetingState createState() => _NewMeetingState();
}

class _NewMeetingState extends State<NewMeeting> {
  // String _meetingCode = "test";
  TextEditingController _meetingCodeController = TextEditingController();

  @override
  // void initState() {
  //   var uuid = Uuid();
  //   _meetingCode = uuid.v1().substring(0, 8);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  child: const Icon(Icons.arrow_back_ios_new_sharp, size: 35),
                  onTap: Get.back,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  //image
                  child: const Image(
                image: AssetImage('assets/blood.jpg'),
                height: 100,
                width: 100,
              )),
              const SizedBox(height: 20),
              const Text(
                "Enter meeting code below",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Card(
                    color: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _meetingCodeController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Example : abc-efg-dhi"),
                    )),
              ),
              const Divider(
                  thickness: 1, height: 35, indent: 20, endIndent: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Share.share("Meeting Code : $_meetingCodeController");
                },
                icon: const Icon(Icons.arrow_drop_down),
                label: const Text("Share invite"),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(350, 30),
                  primary: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoCall(
                            channelName: _meetingCodeController.text.trim())),
                  );
                },
                icon: const Icon(Icons.video_call),
                label: const Text("start call"),
                style: OutlinedButton.styleFrom(
                  primary: Colors.indigo,
                  side: const BorderSide(color: Colors.indigo),
                  fixedSize: const Size(350, 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
