import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:souqporsaid/screens/authentication/signup.dart';
import 'package:souqporsaid/screens/orderDetails/order_details.dart';
import 'package:souqporsaid/screens/product/product_page.dart';
import 'package:souqporsaid/screens/search/search_screen.dart';

import '../responsize.dart';
import 'cart_class.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  double total = 0.0;
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!=null?
      Consumer<ShoppingCart>(
      builder: (context, cart, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
//            leading: GestureDetector(onTap: (){
//              Navigator.pop(context);
//            },child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
            backgroundColor: Colors.black,
            title: Image.asset("assets/appBarLogo.png"),
            centerTitle: true,
            actions: [
              GestureDetector(
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
              ),
            ],
          ),
          body: FirebaseAuth.instance.currentUser != null
              ? SingleChildScrollView(
                  child: cart.cartProducts.length != 0
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height:AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)?MediaQuery.of(context).size.height*0.845: MediaQuery.of(context).size.height * 0.82,
                          decoration: BoxDecoration(
                              color: Color(0xffF8F8F9),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15))),
                          child:Stack(
                            children: [
                              ListView.builder(
                                  itemCount: cart.cartProducts.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.all(10),
                                          child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductPage(
                                                          product:
                                                              cart.cartProducts[
                                                                  index]["product"],
                                                        )));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 88,
                                                  child: AspectRatio(
                                                    aspectRatio: 0.88,
                                                    child: Container(
                                                      padding: EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                        color: Color(0xFFF5F6F9),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15),
                                                      ),
                                                      child: Image.network(cart
                                                              .cartProducts[index]
                                                          ["product"]['images'][0]),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      cart.cartProducts[index]
                                                          ['product']['name'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                      maxLines: 2,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text.rich(
                                                      TextSpan(
                                                        text:
                                                            "EGP${cart.cartProducts[index]['product']['price']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Color(0xFFFF7643)),
                                                        children: [
                                                          TextSpan(
                                                              text:
                                                                  " x${cart.cartProducts[index]["quantity"].toString()}",
                                                              style:
                                                                  Theme.of(context)
                                                                      .textTheme
                                                                      .bodyText1),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      cart.cartProducts[index]
                                                          ["size"]==null ||cart.cartProducts[index]
                                                      ["size"]==null ?"":cart.cartProducts[index]
                                                      ["size"],
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                      maxLines: 2,
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(onPressed: (){
                                                        cart.removeItem(cart.cartProducts[index]);
                                                        setState(() {});
                                                      }, icon: Icon(Icons.close,color: Colors.red,)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ), 
//                                      child: Dismissible(
//                                        key: Key(
//                                            cart.cartProducts[index].toString()),
//                                        direction: DismissDirection.endToStart,
//                                        onDismissed: (direction) {
//                                          cart.removeItem(cart.cartProducts[index]);
//                                          setState(() {});
//                                        },
//                                        background: Container(
//                                          padding:
//                                              EdgeInsets.symmetric(horizontal: 20),
//                                          decoration: BoxDecoration(
//                                            color: Color(0xFFFFE6E6),
//                                            borderRadius: BorderRadius.circular(15),
//                                          ),
//                                          child: Row(
//                                            children: [
//                                              Spacer(),
//                                              Icon(
//                                                Icons.delete_outline,
//                                                color: Colors.red,
//                                              )
//                                            ],
//                                          ),
//                                        ),
//                                        child: GestureDetector(
//                                          onTap: () {
//                                            Navigator.of(context).push(
//                                                MaterialPageRoute(
//                                                    builder: (context) =>
//                                                        ProductPage(
//                                                          product:
//                                                              cart.cartProducts[
//                                                                  index]["product"],
//                                                        )));
//                                          },
//                                          child: Container(
//                                            padding: EdgeInsets.all(10),
//                                            decoration: BoxDecoration(
//                                                borderRadius:
//                                                    BorderRadius.circular(15),
//                                                color: Colors.white),
//                                            child: Row(
//                                              children: [
//                                                SizedBox(
//                                                  width: 88,
//                                                  child: AspectRatio(
//                                                    aspectRatio: 0.88,
//                                                    child: Container(
//                                                      padding: EdgeInsets.all(10),
//                                                      decoration: BoxDecoration(
//                                                        color: Color(0xFFF5F6F9),
//                                                        borderRadius:
//                                                            BorderRadius.circular(
//                                                                15),
//                                                      ),
//                                                      child: Image.network(cart
//                                                              .cartProducts[index]
//                                                          ["product"]['images'][0]),
//                                                    ),
//                                                  ),
//                                                ),
//                                                SizedBox(width: 20),
//                                                Column(
//                                                  crossAxisAlignment:
//                                                      CrossAxisAlignment.start,
//                                                  children: [
//                                                    Text(
//                                                      cart.cartProducts[index]
//                                                          ['product']['name'],
//                                                      style: TextStyle(
//                                                          color: Colors.black,
//                                                          fontSize: 16),
//                                                      maxLines: 2,
//                                                    ),
//                                                    SizedBox(height: 10),
//                                                    Text.rich(
//                                                      TextSpan(
//                                                        text:
//                                                            "EGP${cart.cartProducts[index]['product']['price']}",
//                                                        style: TextStyle(
//                                                            fontWeight:
//                                                                FontWeight.w600,
//                                                            color:
//                                                                Color(0xFFFF7643)),
//                                                        children: [
//                                                          TextSpan(
//                                                              text:
//                                                                  " x${cart.cartProducts[index]["quantity"].toString()}",
//                                                              style:
//                                                                  Theme.of(context)
//                                                                      .textTheme
//                                                                      .bodyText1),
//                                                        ],
//                                                      ),
//                                                    ),
//                                                    SizedBox(height: 10),
//                                                    Text(
//                                                      cart.cartProducts[index]
//                                                          ["size"],
//                                                      style: TextStyle(
//                                                          color: Colors.grey,
//                                                          fontSize: 14),
//                                                      maxLines: 2,
//                                                    ),
//                                                  ],
//                                                ),
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      ),
                                    );
                                  },
                                ),
                              Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.06),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>OrderDetails()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      width: MediaQuery.of(context).size.width*0.9,
                                      height: 50,
                                      child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(cart.allTotalPrice.toString(),style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text("شراء الأن",style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                            ],
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              color:  Color(0xffF8F8F9),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
                            ),        
                    child: Center(
                              child: Text(
                                "لا يوجد منتجات",
                                style: TextStyle(color: Colors.black,fontSize: 20),
                              ),
                            ),
                          ),

          ) : Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text(
                        "Please register first",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
        );
      },
    ): Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color:  Color(0xffF8F8F9),
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
