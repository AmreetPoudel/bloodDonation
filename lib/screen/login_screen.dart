// ignore: file_names
import 'package:blood/screen/home_screen.dart';
import 'package:blood/screen/registration_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key is used in validation of form it is global key with type formstate
  final _formKey = GlobalKey<FormState>();

  //as per design we should have username and password field so to control those two fields we make 2 textediting
  //controller when the text field changes/updates the values then to retrive the text written by user on  those
  //field we use controller
  final TextEditingController emailController =  TextEditingController();
  final TextEditingController passwordController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    //email field

    final emailField = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      //after name type at bottom of keyboard we give next so that user no need to cancel and tap on password field
      textInputAction: TextInputAction.next,
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
          contentPadding: const  EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

//password field similar but no need of autofocus textInputAction

    final passwordField = TextFormField(
      controller: passwordController,
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        passwordController.text = value.toString();
      },
      obscureText: true,
      decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: const  Icon(Icons.vpn_key_outlined),
          contentPadding: const  EdgeInsets.fromLTRB(20, 15, 20, 15),
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
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  

                  children: <Widget> [
                    SizedBox(
                      height: 250,
                      child: Image.asset("assets/blood.jpg" , fit: BoxFit.contain),
                       ),
                    const SizedBox(height: 25,),
                    emailField,
                    const SizedBox(height: 15,),
                    passwordField,
                    const SizedBox(height: 25,),
                    loginButton,
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       const Text("dont have an account?"),
                       GestureDetector(
                         onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegistrationScreen()));
                         },
                         child: const  Text("SignUp",
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
}
