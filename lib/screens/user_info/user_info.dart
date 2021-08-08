import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:souqporsaid/screens/authentication/signup.dart';
import 'package:souqporsaid/screens/search/search_screen.dart';
import 'package:souqporsaid/screens/user_info/body.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: Image.asset("assets/appBarLogo.png"),
        centerTitle: true,
        actions: [
          GestureDetector(child: Icon(Icons.search,color: Colors.white,),onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchPage()));
          },),
        ],
      ),
      body:Body()
    );
  }
}
