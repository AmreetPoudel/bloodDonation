import 'package:blood/model/user_model.dart';
import 'package:blood/screen/buttonNavigationbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import "/model/user_model.dart";
// import 'package:http/http.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  void initState() {
    super.initState();
    initPlatformState();
  }

  final _auth = FirebaseAuth.instance;
  //form key
  final _formkey = GlobalKey<FormState>();
//editing controller
  final firstNameEditingContoller = TextEditingController();
  final secondNameEditingContoller = TextEditingController();
  final districtEditingController = TextEditingController();
  final emailEditingContoller = TextEditingController();
  final passwordEditingContoller = TextEditingController();
  final conformPasswordEditingContoller = TextEditingController();
  String selectedDistrict = 'Achham';
  String selectedBloodGroup = 'AB+';

  var bloodtype = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  var district = [
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

  @override
  Widget build(BuildContext context) {
    //this is for the notification onesignal setup from onesignal official documentation

//first name

    final firstName = TextFormField(
      controller: firstNameEditingContoller,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        firstNameEditingContoller.text = value.toString();
      },
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return " first name cannot be empty";
        }
        if (!regex.hasMatch(value)) {
          return " atleast 3 characters long";
        }
      },
      autofocus: false,
      decoration: InputDecoration(
          hintText: "firstName",
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //second name

    final secondName = TextFormField(
      controller: secondNameEditingContoller,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        secondNameEditingContoller.text = value.toString();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return " second name cannot be empty";
        }
        return null;
      },
      autofocus: false,
      decoration: InputDecoration(
          hintText: "lastName",
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

//discrict

//email controller
    final emailField = TextFormField(
      controller: emailEditingContoller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        emailEditingContoller.text = value.toString();
      },
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return "email cannot be empty";
        }

        // copied from code grapper regex for email validation with reqex
        Pattern pattern =
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?)*$";
        RegExp regex = RegExp(pattern.toString());
        if (!regex.hasMatch(value)) {
          return 'Enter a valid email address';
        } else {
          return null;
        }

        // if (!RegExp("^[a-zA-z0-9+_.-]+@[a-zA-Z09.-]+.[a-z]").hasMatch(value)) {
        //   return "Enter a valid email address";
        // }
        // return null;
      },
      decoration: InputDecoration(
          hintText: "Email",
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //password field

    final passwordField = TextFormField(
      controller: passwordEditingContoller,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        passwordEditingContoller.text = value.toString();
      },
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return " password required for login";
        }
        if (!regex.hasMatch(value)) {
          return " atleast 6 characters long";
        }
      },
      decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: const Icon(Icons.vpn_key_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

//conform password

    final conformPassword = TextFormField(
      controller: conformPasswordEditingContoller,
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        conformPasswordEditingContoller.text = value.toString();
      },
      obscureText: true,
      //validator for conform password
      validator: (value) {
        if (conformPasswordEditingContoller.text !=
            passwordEditingContoller.text) {
          return "password does not match";
        }
        return null;
      },

      decoration: InputDecoration(
          hintText: "ConformPassword",
          prefixIcon: const Icon(Icons.vpn_key_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

//login button

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(50),
      color: Colors.redAccent,
      child: MaterialButton(
        onPressed: () {
          signUp(emailEditingContoller.text, passwordEditingContoller.text);
        },
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: const Text(
          "signUp",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formkey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 250,
                        child: Image.asset("assets/blood.jpg",
                            fit: BoxFit.contain),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      firstName,
                      const SizedBox(
                        height: 15,
                      ),
                      secondName,
                      const SizedBox(
                        height: 15,
                      ),
                      emailField,
                      const SizedBox(
                        height: 10,
                      ),
                      passwordField,
                      const SizedBox(
                        height: 10,
                      ),
                      conformPassword,
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              height: 40,
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                  child: Text('select district',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)))),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.25),
                          Center(
                              child: Text('select bloodType',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 40,
                            padding: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 0.30),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                elevation: 0,
                                value: selectedDistrict,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: district.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedDistrict = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            //check this width on other devices too and
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: const EdgeInsets.all(1.0),
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
                                elevation: 0,
                                value: selectedBloodGroup,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: bloodtype.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedBloodGroup = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      signUpButton
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) => {
                Fluttertoast.showToast(
                    msg: e.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0)
              });
    }
  }

  postDetailsToFirestore() async {
    //these first two lines are for initializing the oneSignal token id
    // var status = await OneSignal.shared.getDeviceState();
    // var tokenId = await OneSignal.shared.getPermissionSubscriptionState();

// var tokenId = OneSignal.getDeviceState().then((value) => {

//   var deviceInfo= JSON.stringify(value);
//   console.log(deviceInfo.userId)
// // });
    final status = await OneSignal.shared.getDeviceState();
    final String? userId = status?.userId;

    //calling firebase
    //calling user model
    //sending data to firebase
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();
    // OneSignal.endInit();

    //writing all the values to constructor of user model so that we can send them to firebase
    userModel.email = user!.email;
    userModel.firstName = firstNameEditingContoller.text;
    userModel.lastName = secondNameEditingContoller.text;
    userModel.uid = user.uid;
    userModel.district = selectedDistrict;
    userModel.bloodType = selectedBloodGroup;
    userModel.tokenId = userId;
    userModel.Password = passwordEditingContoller.text;

    //
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(
        msg: "cheers buddy account created :)",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const ButtonNavigation()),
        (Route<dynamic> route) => false);
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId("6c6a3a20-d3a7-4dea-b5ab-e4a47e61016d");
  }
}
