import 'package:chat_app/screens/registration_screen.dart';
import 'package:chat_app/widgets/roundbutton.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id="WelcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  var colorizeColors = [
    Colors.lightBlue,
    Colors.green,
    Colors.yellow,
    Colors.red,
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: <Widget>[

                Flexible(
                  child: Hero(
                    tag: "logo",



                    child: Container(
                  child: Image.asset('images/logo.png'),
                  height: 100.0,
                    ),
                  ),
                ),

                Text("Flash Chat",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: "Pacifico"
                ),),

              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundButton(
              title: "Log In",
              color: Colors.lightBlueAccent,
              onPress:() {
                Navigator.pushNamed(context,LoginScreen.id);
                //Go to login screen.
              } ,
            ),
            RoundButton(
              title: "Register",
              color: Colors.blueAccent,
              onPress: () {
                Navigator.pushNamed(context,RegistrationScreen.id);
                //Go to registration screen.
              },
            ),



          ],
        ),
      ),
    );
  }
}

/*
TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  )
 */
