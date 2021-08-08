import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:souqporsaid/alertToast.dart';
import 'package:souqporsaid/screens/authentication/signup.dart';
import 'package:souqporsaid/screens/components/custom_buttom_bar.dart';

import '../responsize.dart';
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
          Padding(
            padding: AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)? EdgeInsets.only(left:30,right: 30):EdgeInsets.only(left: 4,right: 4),
            child: ProfileMenu(
              text: FirebaseAuth.instance.currentUser.email.toString(),
              icon: Icons.email,
              press: () => {},
            ),
          ),
          Padding(
            padding: AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)? EdgeInsets.only(left:30,right: 30):EdgeInsets.only(left: 4,right: 4),
            child: ProfileMenu(
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
          ),
        ],
      ),
    ): Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("قم بتسجبل الدخول أولا",style: TextStyle(
                color: Colors.orange,
                fontSize: 30,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
//                  Image.asset("assets/Vector.png"),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.height*0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.orangeAccent),
                ),
                child: Center(
                  child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
