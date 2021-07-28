import 'package:flutter/material.dart';
import 'package:souqporsaid/alertToast.dart';
import 'package:souqporsaid/screens/authentication/login.dart';
import 'information.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String fullName;
  String email;
  String password;
  String reEnterPassword;
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
                          fullName=val;
                        });
                      },
                    decoration: InputDecoration(
                      hintText: "الأسم بالكامل",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2
                      ),
                      prefixIcon: Icon(Icons.person_outline,color: Colors.grey,),
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
                  //Re-Enter Password field
                  Padding(
                    padding:EdgeInsets.only(bottom:8.0),
                    child: TextFormField(
                      onChanged: (val){
                        setState(() {
                          reEnterPassword=val;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "أعادة أدخال كلمة المرور",
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
                      onTap: (){
                        //here sign up functionality
                        if(email!=null && password!=null && fullName!=null && reEnterPassword!=null){
                          if(password == reEnterPassword){
                            if(password.length>8){
                              if(email.contains("@")){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Information(
                                  email: email,
                                  password: password,
                                  fullName: fullName,
                                )));
                              }else{
                                alertToast("البريد الألكتروني غير صالح !",Color(0xffFA953D) , Colors.black);
                              }
                            }else{
                              alertToast("كلمة المرور ضعيفة !",Color(0xffFA953D) , Colors.black);
                            }
                          }else{
                            alertToast("عدم تطابق كلمتي المرور !",Color(0xffFA953D) , Colors.black);
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
                            child: Text("التالي",style: TextStyle(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                      },
                        child:Text("تسجيل الدخول",style: TextStyle(color: Color(0xffFA953D)),),
                      ),
                      Text(" هل تمتلك حسااب ؟ ",style: TextStyle(color: Colors.white,letterSpacing: 2),),
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
