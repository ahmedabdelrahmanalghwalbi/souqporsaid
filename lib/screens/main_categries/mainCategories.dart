import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:souqporsaid/screens/home_page/productTestModel.dart';
import 'package:souqporsaid/screens/main_categries/subCategories.dart';
import 'package:souqporsaid/screens/search/search_screen.dart';

import '../responsize.dart';

class MainCategories extends StatefulWidget {
  @override
  _MainCategoriesState createState() => _MainCategoriesState();
}

class _MainCategoriesState extends State<MainCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset("assets/appBarLogo.png"),
        centerTitle: true,
        actions: [
          GestureDetector(child: Icon(Icons.search,color: Colors.white,),onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
          },),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Category").snapshots(),
        builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return Center(
              child: Text('يوجد خطأ في تحميل الفئات',textAlign: TextAlign.center,style: TextStyle(
                color: Colors.orange
              ),),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.orange,));
          }
          return GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)?5:2,
                childAspectRatio:0.9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 5
            ),
            children: snapshot.data.docs.map<Widget>((DocumentSnapshot document){
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategory(subCategories: data['subCategories'],category: data["name"],imageUrl: data['subImageUrl'],)));
                },
                child: Card(
                  color: Colors.black,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child:Image.network(data["imageUrl"])),
                        Expanded(child: Center(child: Text(data["name"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ))),
                      ],
                    ),
                  ),
                ),
              );
            }
          ).toList(),
          );
        }
      ),
    );
  }
}
