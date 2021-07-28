import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:souqporsaid/screens/product/product_page.dart';
import 'package:souqporsaid/screens/search/search_screen.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  double total =0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: Image.asset("assets/appBarLogo.png"),
        centerTitle: true,
        actions: [
          GestureDetector(child: Icon(Icons.search,color: Colors.white,),onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchPage()));
          },),
        ],
      ),
      body:FirebaseAuth.instance.currentUser!=null?SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.9,
            decoration: BoxDecoration(
                color: Color(0xffF8F8F9),
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
            ),
            child:Stack(
              children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("ShoppingCart").snapshots(),
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
                  return ListView(
                    children: snapshot.data.docs.map<Widget>((DocumentSnapshot document){
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      if(data["userId"]== FirebaseAuth.instance.currentUser.uid){
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Dismissible(
                            key: Key(document.id.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction)async {
                              FirebaseFirestore.instance.collection("ShoopingCart").doc(document.id).delete().then((value) {
                                print("successfully");
                              }).catchError((ex){
                                print("error in deleting this from shopping cart $ex");
                              });
                            },
                            background: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFE6E6),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Icon(Icons.delete_outline,color: Colors.red,)
                                ],
                              ),
                            ),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductPage(product:data["product"] ,)));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white
                                ),
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
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Image.network(data["product"]['images'][0]),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data['product']['name'],
                                          style: TextStyle(color: Colors.black, fontSize: 16),
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 10),
                                        Text.rich(
                                          TextSpan(
                                            text: "EGP${data['product']['price']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600, color: Color(0xFFFF7643)),
                                            children: [
                                              TextSpan(
                                                  text: " x${data["quantity"].toString()}",
                                                  style: Theme.of(context).textTheme.bodyText1),
                                            ],
                                          ),

                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          data["size"],
                                          style: TextStyle(color: Colors.grey, fontSize: 14),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }else{
                        return Container();
                      }
                    }
                    ).toList(),
                  );
                }
            ),
//                Align(
//                  alignment: Alignment.bottomCenter,
//                  child:Container(
//                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.15),
//                    width: MediaQuery.of(context).size.width/2,
//                    height: MediaQuery.of(context).size.height*0.08,
//                    decoration: BoxDecoration(
//                      color: Colors.green,
//                      borderRadius: BorderRadius.circular(20)
//                    ),
//                    child: Center(
//                      child: Row(
//                        children: [
//                          Text("شراء",style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 20,
//                            fontWeight: FontWeight.bold
//                          ),),
//                          Text(total.toString(),style: TextStyle(
//                              color: Colors.white,
//                              fontSize: 20,
//                              fontWeight: FontWeight.bold
//                          ),),
//                        ],
//                      ),
//                    ),
//                  )
//                ),
              ])
//              :Center(
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                Text("لا يوجد منتجات مفضلة",style: TextStyle(
//                    color: Colors.orange,
//                    fontSize: 30,
//                    fontWeight: FontWeight.bold
//                ),),
//                SizedBox(height: MediaQuery.of(context).size.height*0.1,),
//                Image.asset("assets/Vector.png"),
//              ],
//            ),
//          ),
        ),
      ):Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
            color: Colors.white
        ),
      ),
    );
  }
}
