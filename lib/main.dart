import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:souqporsaid/screens/cart/cart_class.dart';
import 'package:souqporsaid/screens/splash_screen/splash_scrreen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context)=>ShoppingCart(),
      child: SplashScreen())
  );
}