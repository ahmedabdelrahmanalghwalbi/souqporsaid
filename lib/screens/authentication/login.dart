import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:souqporsaid/screens/authentication/signup.dart';
import 'package:souqporsaid/screens/components/custom_buttom_bar.dart';

import '../../alertToast.dart';
import '../responsize.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top,left: AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)?50:10,right: AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)?50:10),
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
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("سوق بورسعيد",style: TextStyle(
                              color: Color(0xffFA953D),
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                              letterSpacing: 1
                          ),),
                          Text("أهلا بك في",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              letterSpacing: 1
                          ),),
                        ],
                      ),
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
                    //email field
                    Padding(
                      padding:EdgeInsets.only(bottom:8.0),
                      child: TextFormField(
                        onChanged: (val){
                          setState(() {
                            email=val;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "البريد الألكتروني",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              letterSpacing: 2
                          ),
                          prefixIcon: Icon(Icons.email_outlined,color: Colors.grey,),
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
                            password=val;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "كلمة المرور",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              letterSpacing: 2
                          ),
                          prefixIcon: Icon(Icons.lock_outline,color: Colors.grey,),
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
                            if(email!=null && password!=null){
                              if(email.contains("@")){
                                if(password.length>8){
                                  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>CustomBottomBar()));
                                  }).catchError((ex){
                                    print(ex);
                                    alertToast("خطأ أثناء تسجيل الدخول !",Color(0xffFA953D) , Colors.black);
                                  });
                                }else{
                                  alertToast("كلمة المرور ضعيفة !",Color(0xffFA953D) , Colors.black);
                                }
                              }else{
                                alertToast("البريد الألكتروني غير صالح !",Color(0xffFA953D) , Colors.black);

                              }
                            }else{
                              alertToast("رجاء قم بأدخال كل البيانات !",Color(0xffFA953D) , Colors.black);
                            }
                            //here sign up functionality
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CustomBottomBar()));
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
                    //have an account ? statement
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(onTap: (){
                          // Navigator to sign in screen
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                        },
                          child:Text("أشتراك",style: TextStyle(color: Color(0xffFA953D)),),
                        ),
                        Text("لا تمتلك حساب ؟ ",style: TextStyle(color: Colors.white,letterSpacing: 2),),
                      ],
                    ),
                  ],),)),
            ],
          ),
        ),
      ),
    );
  }
}
