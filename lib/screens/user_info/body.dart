import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:souqporsaid/alertToast.dart';
import 'package:souqporsaid/screens/components/custom_buttom_bar.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!=null?SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          ProfileMenu(
            text: "أحمد عبد الرحمن",
            icon: Icons.person,
            press: () {},
          ),
          ProfileMenu(
            text: FirebaseAuth.instance.currentUser.email.toString(),
            icon: Icons.email,
            press: () => {},
          ),
          ProfileMenu(
            text: "بورسعيد حي الزهور",
            icon: Icons.alarm,
            press: () {},
          ),
          ProfileMenu(
            text: "01274961136",
            icon: Icons.settings,
            press: () {},
          ),
          ProfileMenu(
            text: "تسجيل الخروج",
            icon: Icons.logout,
            press: () async{
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>CustomBottomBar()));
              }).catchError((ex){
                alertToast("خطأ أثناء تسجيل الخروج", Colors.orange, Colors.black);
              });
            },
          ),
        ],
      ),
    ):Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
        color: Colors.white
      ),
    );
  }
}
