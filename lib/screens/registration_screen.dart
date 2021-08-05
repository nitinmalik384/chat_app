import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/roundbutton.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id="RegistrationScreen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final  _auth=FirebaseAuth.instance;
  bool showSpinner=false;

  String email,password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        color: Colors.white,
        progressIndicator:SpinKitWave(
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
            );
          },
          size: 50,
        ),

        opacity: 0.5,
        inAsyncCall: showSpinner ,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  email=value;
                  //Do something with the user input.
                },
                  style: TextStyle(color:Colors.black),
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your email",

                ),
                keyboardType:TextInputType.emailAddress,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(

                onChanged: (value) {
                  password=value;
                  //Do something with the user input.
                },
                  obscureText: true,
                  style: TextStyle(color:Colors.black),
                  textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your password",

                )
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundButton(
                title: "Register",
                color: Colors.blueAccent,
                onPress: () async {
                  setState(() {
                    showSpinner=true;});


               try{
                 final newuser= await _auth.createUserWithEmailAndPassword(email: email, password: password);
                 if(newuser!=null)
                   Navigator.pushNamed(context, ChatScreen.id);

               }catch(e)
                  {print(e);}
                  setState(() {
                    showSpinner=false;});



                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
