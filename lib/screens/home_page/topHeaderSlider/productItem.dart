import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souqporsaid/alertToast.dart';
import 'package:souqporsaid/screens/authentication/signup.dart';
import 'package:souqporsaid/screens/home_page/productTestModel.dart';
import 'package:souqporsaid/screens/product/product_page.dart';
import 'package:souqporsaid/screens/product/view_product_page.dart';

class ProductItem extends StatefulWidget {
  final Map<String, dynamic> product;
  ProductItem({this.product});
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isRed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>ViewProductPage(product: widget.product,)));
      },
      child: Card(
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange
                    ),
                    child: Center(
                      child: Text("${widget.product["discount"].toString()}%",style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()async{
                      if(FirebaseAuth.instance.currentUser!=null){
                        FirebaseFirestore.instance.collection("Favorite").add({
                          "product":widget.product,
                          "userId":FirebaseAuth.instance.currentUser.uid
                        }).then((value){
                          setState(() {
                            isRed=true;
                          });
                        }).catchError((ex){
                          print("Exception in adding the product to the favorites $ex");
                          alertToast("خطأ أثناء أضافة المنتج للمفضلة !",Color(0xffFA953D), Colors.black);
                        });
                      }else{
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));
                      }
                    },
                      child:Icon(Icons.favorite,color: Colors.red,),
                  )
                ],
              ),
              Expanded(child: ClipOval(
                child: AspectRatio(
                    aspectRatio: 0.8,
                    child:Image.network(widget.product["images"][0], fit: BoxFit.contain,)
                ),
              )),
              const SizedBox(height: 10,),
              Expanded(child: Column(
                children: [
                  Text(widget.product["name"],maxLines: 2,style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
                  ),textAlign: TextAlign.center),
                  const SizedBox(height: 10,),
                  Text(widget.product["price"].toString(),maxLines:2,style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),textAlign: TextAlign.center,),
                  const SizedBox(height: 5,),
                ],
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
