import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import "package:cloud_firestore/cloud_firestore.dart";

final _firestore=FirebaseFirestore.instance;
final _auth=FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  static const String id="ChatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
 final _auth=FirebaseAuth.instance;
 final controller=TextEditingController();

 String message;
 var loggedInUser;
 List<Text> messageList=[];

  @override
  initState(){
    getCurrentUser();
  }


 getCurrentUser()async{
   try{
     final user=await _auth.currentUser;
     if(user!=null)
     {
       loggedInUser=user.email;
       print(user.email);
     }
   }catch(e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await _auth.signOut();
               Navigator.pop(context);



              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStreamer(),

            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        message=value;
                        //Do something with the user input.
                      },
                      style: TextStyle(color:Colors.black54),
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      controller.clear();
                      var a=_firestore.collection("messages").add({
                        'text':message,
                        'sender':loggedInUser
                      });

                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream: _firestore.collection("messages").snapshots(),
      builder: (context,snapshot){

        final messages=snapshot.data.docs;
        List<Widget> messageWidgetList=[];


        for(var message in messages)
        {
          final messageText=message.data()["text"];
          final messageSender=message.data()["sender"];
          final currentUser=_auth.currentUser.email;
          final messageWidget=MessageBubble(
            messageSender: messageSender,
            messageText: messageText,
            isMe: currentUser==messageSender,
          );
          messageWidgetList.add(messageWidget);}


        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            children: messageWidgetList,
          ),
        );

      } ,);
  }
}
class MessageBubble extends StatelessWidget {
  final messageText;
  final messageSender;
  final isMe;
  MessageBubble({this.messageText,this.messageSender,this.isMe});

  changeColor()
  {
    if(isMe)
      return Colors.lightBlueAccent;
    else
      return Colors.blueAccent;
  }
  changeRadius()
  {
    if(isMe)
      return  BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
        topLeft: Radius.circular(30),

      );
    else
      return  BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
        topRight: Radius.circular(30),

      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(messageSender,style: TextStyle(color: Colors.black54,
          fontSize: 12.0),),
          Material(
            borderRadius:changeRadius(),
            elevation: 1,
            animationDuration: Duration(seconds: 2),
            color: changeColor(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: Text("$messageText ",
              style:TextStyle(color:Colors.white,
              fontSize: 15)),
            )
          ),
        ],
      ),
    );
  }
}

