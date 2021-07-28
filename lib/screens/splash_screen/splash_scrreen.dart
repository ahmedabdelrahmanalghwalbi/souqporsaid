import 'package:flutter/material.dart';
import 'package:souqporsaid/screens/authentication/login.dart';
import 'package:souqporsaid/screens/authentication/signup.dart';
import 'package:souqporsaid/screens/components/custom_buttom_bar.dart';
import 'package:souqporsaid/screens/home_page/home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash(),
            debugShowCheckedModeBanner: false,);
        } else {
          // Loading is done, return the app:
          //here i will set the home
          return MaterialApp(
            home: CustomBottomBar(),
            debugShowCheckedModeBanner: false,
          );
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("assets/logo1.png")
      ),
    );
  }
}