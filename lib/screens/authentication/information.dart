import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souqporsaid/screens/components/custom_buttom_bar.dart';

import '../../alertToast.dart';

class Information extends StatefulWidget {
  final String fullName;
  final String email;
  final String password;
  Information({this.fullName,this.email,this.password});
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  String flatNumber;
  String streetAndRegion;
  String countrySection;
  String phoneNumber;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          width: width,
          height: height,
          child: Column(
            children: [
              //logo section
              Expanded(flex:3,child: Container(
                child: Column(
                  children: [
                    //logo image section
                    Expanded(flex:2,child: Container(child: Row(
                      children: [
                        Expanded(flex:1,child: Container()),
                        Expanded(flex:3,child: Container(decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/logo1.png"),
                                fit: BoxFit.contain
                            )
                        ),)),
                        Expanded(flex:1,child: Container()),
                      ],
                    ),)),
                    //create a new account statement
                    Expanded(flex:1,child: Container(child: Center(
                      child:Text("عمل حساب جديد",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          letterSpacing: 1
                      ),textAlign: TextAlign.center,),
                    ),))
                  ],
                ),
              )),
              // form section
              Expanded(flex:7,child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //full name text form field
                    Padding(
                      padding:EdgeInsets.only(bottom:8.0),
                      child: TextFormField(
                        onChanged: (val){
                          setState(() {
                            flatNumber=val;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "رقم الشقة و العمارة / البرج",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              letterSpacing: 2
                          ),
                          prefixIcon: Icon(Icons.location_on,color: Colors.grey,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    //email field
                    Padding(
                      padding:EdgeInsets.only(bottom:8.0),
                      child: TextFormField(
                        onChanged: (val){
                          setState(() {
                            streetAndRegion=val;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "الشارع أو المنطقة",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              letterSpacing: 2
                          ),
                          prefixIcon: Icon(Icons.location_on,color: Colors.grey,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    //password field
                    Padding(
                      padding:EdgeInsets.only(bottom:8.0),
                      child: TextFormField(
                        onChanged: (val){
                          setState(() {
                            countrySection=val;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "الحي",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              letterSpacing: 2
                          ),
                          prefixIcon: Icon(Icons.location_on,color: Colors.grey,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    //Re-Enter Password field
                    Padding(
                      padding:EdgeInsets.only(bottom:8.0),
                      child: TextFormField(
                        onChanged: (val){
                          setState(() {
                            phoneNumber=val;
                          });
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "رقم الهاتف",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              letterSpacing: 2
                          ),
                          prefixIcon: Icon(Icons.phone,color: Colors.grey,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    //Sign Up Button
                    Padding(padding: EdgeInsets.only(bottom: 30,top: 20),
                        child:GestureDetector(
                          onTap: ()async{
                            //here sign up functionality
                            if(phoneNumber!=null && countrySection!=null && flatNumber!=null && streetAndRegion!=null){
                              if(phoneNumber.length==11){
                                await FirebaseAuth.instance.createUserWithEmailAndPassword(email: widget.email,password: widget.password).then((value)async{
                                await FirebaseFirestore.instance.collection("Users").add({
                                  "name":widget.fullName,
                                  "userId":FirebaseAuth.instance.currentUser.uid,
                                  "password":widget.password,
                                  "email":widget.email,
                                  "flatNumber":flatNumber,
                                  "streetAndRegion":streetAndRegion,
                                  "countrySection":countrySection,
                                  "phoneNumber":phoneNumber
                                }).then((value)async{
                                  var pref = await SharedPreferences.getInstance();
                                  var userId= FirebaseAuth.instance.currentUser.uid;
                                  pref.setString("userId", userId);
                                  pref.setString("userEmail", widget.email);
                                  pref.setString("userName", widget.fullName);
                                  pref.setBool("isAuth", true);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CustomBottomBar()));
                                }).catchError((ex){
                                  print(ex);
                                  alertToast("يوجد مشكلة أثناء عمل الحساب", Color(0xffFA953D), Colors.black);
                                });
                                }).catchError((ex){
                                  print(ex);
                                  alertToast(ex, Color(0xffFA953D), Colors.black);
                                });
                              }else{
                                alertToast("أدخل رقم هاتف صالح !",Color(0xffFA953D) , Colors.black);
                              }
                            }else{
                              alertToast("رجاء قم بأدخال كل البيانات !",Color(0xffFA953D) , Colors.black);
                            }
                          },
                          child: Container(
                            width: width,
                            height: height*0.07,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffFA953D)
                            ),
                            child: Center(
                              child: Text("تسجيل الدخول",style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),),
                            ),
                          ),
                        )
                    ),
                  ],),)),
            ],
          ),
        ),
      ),
    );
  }
}
