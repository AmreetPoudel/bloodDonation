// ignore: file_names, unused_import
import 'package:blood/screen/home_screen.dart';
import 'package:blood/screen/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'buttonNavigationbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  //form key is used in validation of form it is global key with type formstate
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  //as per design we should have username and password field so to control those two fields we make 2 textediting
  //controller when the text field changes/updates the values then to retrive the text written by user on  those
  //field we use controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late Box box1;
  final _auth = FirebaseAuth.instance; //firebase auth instance

  @override
  void initState() {
    super.initState();
    createBox();
  }

  void createBox() async {
    box1 = await Hive.openBox('logindata');
    getdata();
  }

  void getdata() async {
    if (box1.get('email') != null) {
      emailController.text = box1.get('email');
      isChecked = true;
      setState(() {});
    }
    if (box1.get('password') != null) {
      passwordController.text = box1.get('password');
      isChecked = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    //email field

    final emailField = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      //after name type at bottom of keyboard we give next so that user no need to cancel and tap on password field
      textInputAction: TextInputAction.next,
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
      onSaved: (value) {
        emailController.text = value.toString();
      },
      //we allow the keyboard to open only when the user tap on the blank space else donot open
      //default value of autofocus is true so keyboard opens when text field is focused(accidentlly) so to open  only on
      // tap we made autofocus false.........................
      autofocus: false,
      decoration: InputDecoration(
          hintText: "Email",
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

//password field similar but no need of autofocus textInputAction

    final passwordField = TextFormField(
      controller: passwordController,
      // ignore: body_might_complete_normally_nullable
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return " password required for login";
        }
        if (!regex.hasMatch(value)) {
          return " atleast 6 characters long";
        }
      },
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        // ignore: unused_local_variable
        passwordController.text = value!.toString();
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

    //customized login button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(50),
      color: Colors.redAccent,
      child: MaterialButton(
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: const Text(
          "login",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // CHeck for Errors
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error: ${snapshot.error}",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20,
              ),
            ),
          );
        }
        // once Completed, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
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
                          emailField,
                          const SizedBox(
                            height: 15,
                          ),
                          passwordField,
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              const Text(
                                "Remember Me",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 99, 168, 21)),
                              ),
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  isChecked = !isChecked;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Forgot Password ? Reset Now",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                          loginButton,
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text("dont have an account?"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegistrationScreen()));
                                },
                                child: const Text(
                                  "SignUp",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

//login functionality

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (uid) => {
              Fluttertoast.showToast(
                  msg: "login successful",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white,
                  textColor: Colors.green,
                  fontSize: 16.0),
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const ButtonNavigation())),
            },
          )
          // ignore: invalid_return_type_for_catch_error
          //commented code is ok tested but this is for every possible case so we can handle all the possible errors
          // ignore: invalid_return_type_for_catch_error
          .catchError((e) => {
                if (e.toString().contains("ERROR_WRONG_PASSWORD"))
                  {
                    Fluttertoast.showToast(
                        msg: "incorrect password",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.red,
                        fontSize: 16.0),
                  }
                else if (e.toString().contains("ERROR_USER_NOT_FOUND"))
                  {
                    Fluttertoast.showToast(
                        msg: "user not found",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.red,
                        fontSize: 16.0),
                  }
                else
                  {
                    Fluttertoast.showToast(
                        msg: e.toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.red,
                        fontSize: 16.0),
                  }
              });

      if (isChecked) {
        box1.put("email", emailController.text);
        box1.put("password", passwordController.text);
      }
    }

    // Fluttertoast.showToast(
    //     msg: e!.message,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.redAccent,
    //     textColor: Colors.white,
//                 //     fontSize: 16.0),
//               });
//     }
//   }
// }}
  }
}
