import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,

      ) ,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                SizedBox(height: 200,
                child: Image.asset("assets/blood.jpg"),),
                const Text(
                  "welcome to blood donation app",
                   style:TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                     color: Colors.redAccent),
                     ),
                const SizedBox(height: 10,),
                const Text("name of logined in user",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
                ),
                const SizedBox(height: 5,),
                const Text("registred email",style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
                ),
                const SizedBox(height: 20,) ,

                //log out button

                //tried to make a button using existing knowledge(raised button and container converted to button) but failed 
                //but this worked.
                //actionchip is used to trigger and action when user presses the chip
                ActionChip(label:  const Text('logout'), onPressed: (){})

            ],
                ),  
                    )
                  ),
            );
            }
            }