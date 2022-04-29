import 'package:blood/model/user_model.dart';
import 'package:blood/screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "/model/user_model.dart";

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  //form key
  final _formkey = GlobalKey<FormState>();
//editing controller
  final firstNameEditingContoller = TextEditingController();
  final secondNameEditingContoller = TextEditingController();
  final emailEditingContoller = TextEditingController();
  final passwordEditingContoller = TextEditingController();
  final conformPasswordEditingContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                        height: 25,
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
          .then((value)=>{ postDetailsToFirestore()})
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
    //calling firebase
    //calling user model
    //sending data to firebase
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    //writing all the values to constructor of user model so that we can send them to firebase
    userModel.email = user!.email;
    userModel.firstName = firstNameEditingContoller.text;
    userModel.lastName = secondNameEditingContoller.text;
    userModel.uid = user.uid;

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
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false);
    
  }
}
