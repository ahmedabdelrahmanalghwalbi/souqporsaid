import 'package:flutter/material.dart';
import 'package:souqporsaid/screens/authentication/signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Welcome to ",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              letterSpacing: 1
                          ),),
                          Text("SouQ Portsaid ",style: TextStyle(
                              color: Color(0xffFA953D),
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
                        decoration: InputDecoration(
                          hintText: "Your Email",
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
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
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
                          },
                          child: Container(
                            width: width,
                            height: height*0.07,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffFA953D)
                            ),
                            child: Center(
                              child: Text("Sign In",style: TextStyle(
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
                        Text("Don't Have an Account ? ",style: TextStyle(color: Colors.white,letterSpacing: 2),),
                        GestureDetector(onTap: (){
                          // Navigator to sign in screen
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                        },
                          child:Text("Register",style: TextStyle(color: Color(0xffFA953D)),),
                        ),
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
