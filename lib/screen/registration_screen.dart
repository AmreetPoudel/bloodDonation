import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
        onPressed: () {},
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
}
