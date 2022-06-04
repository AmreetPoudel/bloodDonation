import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Updateuser extends StatefulWidget {
  final String id;
  Updateuser({Key? key, required this.id}) : super(key: key);

  @override
  _UpdateuserState createState() => _UpdateuserState();
}

class _UpdateuserState extends State<Updateuser> {
  TextEditingController firstNameEditingContoller = TextEditingController();
  TextEditingController lastNameEditingContoller = TextEditingController();
  TextEditingController emailEditingContoller = TextEditingController();
  TextEditingController passwordEditingContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Updaing Student
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  // ignore: non_constant_identifier_names
  Future<void> updateUser(id, firstName, lastName, email, Password) {
    return user
        .doc(id)
        .update({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'Password': Password
        })
        .then((value) => Fluttertoast.showToast(
            msg: "User Updated Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0))
        .catchError((error) => Fluttertoast.showToast(
            msg: "Error: $error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update credentials"),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error: ${snapshot.error}",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var firstName = data!['firstName'];
              var lastName = data!['lastName'];
              var email = data['email'];
              var Password = data['Password'];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    TextFormField(
                      autocorrect: true,
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
                        return null;
                      },
                      autofocus: false,
                      decoration: InputDecoration(
                          hintText: "firstName",
                          prefixIcon: const Icon(Icons.account_circle),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    TextFormField(
                      controller: lastNameEditingContoller,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        lastNameEditingContoller.text = value.toString();
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    TextFormField(
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    TextFormField(
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
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.vpn_key_outlined),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      // decoration: new BoxDecoration(color: Colors.red[200]),
                      // Color: Colors.blue,,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            // color: Colors.blue,
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState!.validate()) {
                                updateUser(
                                    widget.id,
                                    firstNameEditingContoller.text,
                                    lastNameEditingContoller.text,
                                    emailEditingContoller.text,
                                    passwordEditingContoller.text);
                                Navigator.pop(context);
                              }
                            },
                            // ignore: prefer_const_constructors
                            child: Text(
                              'Update',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                // Color: Colors.white,
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
