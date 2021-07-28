import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:souqporsaid/screens/authentication/signup.dart';
import 'package:souqporsaid/screens/home_page/productTestModel.dart';
import 'package:souqporsaid/screens/product/product_page.dart';

import '../../../alertToast.dart';

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;
  ProductCard({this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.orange[100].withOpacity(.2),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          width:170,
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductPage(product: widget.product)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.3,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF979797).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Hero(
                      tag: widget.product['name'].toString(),
                      child: Image.network(widget.product['images'][0]),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.product["name"],
                  style: TextStyle(color: Colors.black),
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "EGP ${widget.product["price"].toString()}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color:  Color(0xFFFF7643),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () async{
                        print("[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[");
                        if(FirebaseAuth.instance.currentUser!=null){
                          FirebaseFirestore.instance.collection("Favorite").add({
                            "product":widget.product,
                            "userId":FirebaseAuth.instance.currentUser.uid
                          }).then((value){
                            print("added successfully");
                          }).catchError((ex){
                            print("Exception in adding the product to the favorites $ex");
                            alertToast("خطأ أثناء أضافة المنتج للمفضلة !",Color(0xffFA953D), Colors.black);
                          });
                        }else{
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Icon(Icons.favorite,color: Colors.red,))
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
