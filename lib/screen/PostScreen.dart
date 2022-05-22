//this is post screen and in this screen we have large text area with and three buttons one for post one for cancel
// and one for upload image

// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  // final _auth = FirebaseAuth.instance;
  String? requiredDistrict;
  String? requiredBloodGroup;
  User? user = FirebaseAuth.instance.currentUser;
  //controller for text field
  final TextEditingController postEditingController = TextEditingController();
  final TextEditingController districtEditingController =
      TextEditingController();
  final TextEditingController bloodEditingController = TextEditingController();
  final TextEditingController phoneEditingController = TextEditingController();

  var bloodtype = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  var districts = [
    'Achham',
    'Arghakhanchi',
    'Baglung',
    'Baitadi',
    'Bajhang',
    'Bajura',
    'Banke',
    'Bara',
    'Bardiya',
    'Bhaktapur',
    'Bhojpur',
    'Chitwan',
    'Dadeldhura',
    'Dailekh',
    'Dang',
    'Darchula',
    'Dhading',
    'Dhankuta',
    'Dhanusha',
    'Dolakha',
    'Dolpa',
    'Doti',
    'Gorkha',
    'Gulmi',
    'Humla',
    'Illam',
    'Jajarkot',
    'Jhapa',
    'Jumla',
    'Kailali',
    'Kalikot',
    'Kanchanpur',
    'Kapilavastu',
    'Kaski',
    'Kathmandu',
    'Kavrepalanchok',
    'Khotang',
    'Lalitpur',
    'Lamjung',
    'Mahottari',
    'Makwanpur',
    'Manang',
    'Morang',
    'Mugu',
    'Mustang',
    'Myagdi',
    'Nawalpur',
    'Nuwakot',
    'Okhaldhunga',
    'Palpa',
    'Panchthar',
    'Parasi',
    'Parbat',
    'Parsa',
    'Pyuthan',
    'Ramechhap',
    'Rasuwa',
    'Rautahat',
    'Rolpa',
    'Rukum',
    'Rupandehi',
    'Salyan',
    'Sankhuwasabha',
    'Saptari',
    'Sarlahi',
    'Sindhuli',
    'Sindhupalchok',
    'Siraha',
    'Solukhumbu',
    'Sunsari',
    'Surkhet',
    'Syangja',
    'Tanahun',
    'Taplejung',
    'Tehrathum',
    'Udayapur'
  ];
  final maxlines = 19;

  void dispose() {
    // Clean up the controller when the widget is disposed.
    postEditingController.dispose();
    districtEditingController.dispose();
    bloodEditingController.dispose();
    phoneEditingController.dispose();
    super.dispose();
  }

  clearText() {
    postEditingController.clear();
    districtEditingController.clear();
    bloodEditingController.clear();
    phoneEditingController
        .clear(); //this is for clearing the text field after the post is done
  }

  String post = "";
  String phoneNumber = "";

  setdata() {
    post = postEditingController.text;
    phoneNumber = phoneEditingController.text;
  }

//adding post,district and blood group to firebase
  // Adding Student
  CollectionReference data = FirebaseFirestore.instance.collection('Post');

  Future<void> addUser() {
    return data
        .add({
          'post': post,
          'district': requiredDistrict,
          'bloodGroup': requiredBloodGroup,
          "phoneNo": phoneEditingController.text,
          'uid': user!.uid,
        })
        .then((value) => {
              Fluttertoast.showToast(
                  msg: "Post Added",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0),
            })
        .catchError((error) => {
              Fluttertoast.showToast(
                  msg: "Post failed",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0)
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: true,
        //   title: Text(
        //     "post the blood donation request",
        //     style: TextStyle(
        //       fontSize: 20,
        //       fontWeight: FontWeight.bold,
        //       shadows: [
        //         Shadow(
        //           blurRadius: 10.0,
        //           color: Color.fromARGB(255, 17, 15, 15).withOpacity(0.1),
        //           offset: Offset(5.0, 5.0),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        backgroundColor: Colors.red.shade200,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: <Widget>[
                      const SizedBox(
                        height: 40,
                        child: Center(
                          child: Text(
                            "blood request",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
//post the message this is text field
                      Container(
                        margin: EdgeInsets.all(12),
                        height: maxlines * 21,
                        child: TextField(
                          controller: postEditingController,
                          maxLines: maxlines,
                          decoration: InputDecoration(
                            hintText: "Enter a message",
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                        ),
                      ),

                      //two buttons for post and cancel
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 40,
                            //check this width on other devices too and
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 0.30,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: const Text("select district"),
                                elevation: 0,
                                value: requiredDistrict,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: districts.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    requiredDistrict = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            //check this width on other devices too and
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 0.30,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: const Text("blood type"),
                                elevation: 0,
                                value: requiredBloodGroup,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: bloodtype.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    requiredBloodGroup = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      //,one button for upload image
                      TextField(
                        controller: phoneEditingController,
                        decoration: const InputDecoration(
                          hintText: 'phone Number',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      //input field to take phone number form user

                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.redAccent,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              setdata();
                              addUser();
                              clearText();
                            });
                          },
                          padding: const EdgeInsets.all(10),
                          minWidth: MediaQuery.of(context).size.width * 0.40,
                          child: const Text(
                            "Request",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ]))),
          ),
        ));
  }
}
