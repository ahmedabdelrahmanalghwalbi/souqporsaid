import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:souqporsaid/alertToast.dart';
import 'package:souqporsaid/screens/authentication/signup.dart';
import 'package:souqporsaid/screens/product/product_page.dart';
import 'package:souqporsaid/screens/product/view_product_page.dart';
import 'package:souqporsaid/screens/search/search_screen.dart';
class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool favProducts=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
//        leading: GestureDetector(onTap: (){
//          Navigator.pop(context);
//        },child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
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
          child:StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Favorite").snapshots(),
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
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewProductPage(product:data["product"] ,)));
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
                                        ),
                                      )
                                    ],
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(onPressed: (){
                                        FirebaseFirestore.instance.collection("Favorite").doc(document.id).delete().then((value) {
                                      print("successfully");
                                     }).catchError((ex){
                                         print("error in deleting this favorite product $ex");
                                       });
                                        }, icon: Icon(Icons.close,color: Colors.red,)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
//                        child: Dismissible(
//                          key: Key(document.id.toString()),
//                          direction: DismissDirection.endToStart,
//                          onDismissed: (direction)async {
//                            FirebaseFirestore.instance.collection("Favorite").doc(document.id).delete().then((value) {
//                              print("successfully");
//                            }).catchError((ex){
//                              print("error in deleting this favorite product $ex");
//                            });
//                          },
//                          background: Container(
//                          padding: EdgeInsets.symmetric(horizontal: 20),
//                          decoration: BoxDecoration(
//                          color: Color(0xFFFFE6E6),
//                          borderRadius: BorderRadius.circular(15),
//                          ),
//                            child: Row(
//                              children: [
//                                Spacer(),
//                                Icon(Icons.delete_outline,color: Colors.red,)
//                              ],
//                            ),
//                          ),
//                          child: GestureDetector(
//                            onTap: (){
//                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductPage(product:data["product"] ,)));
//                            },
//                            child: Container(
//                              padding: EdgeInsets.all(10),
//                              decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(15),
//                                color: Colors.white
//                              ),
//                              child: Row(
//                                children: [
//                                  SizedBox(
//                                    width: 88,
//                                    child: AspectRatio(
//                                      aspectRatio: 0.88,
//                                      child: Container(
//                                        padding: EdgeInsets.all(10),
//                                        decoration: BoxDecoration(
//                                          color: Color(0xFFF5F6F9),
//                                          borderRadius: BorderRadius.circular(15),
//                                        ),
//                                        child: Image.network(data["product"]['images'][0]),
//                                      ),
//                                    ),
//                                  ),
//                                  SizedBox(width: 20),
//                                  Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: [
//                                      Text(
//                                        data['product']['name'],
//                                        style: TextStyle(color: Colors.black, fontSize: 16),
//                                        maxLines: 2,
//                                      ),
//                                      SizedBox(height: 10),
//                                      Text.rich(
//                                        TextSpan(
//                                          text: "EGP${data['product']['price']}",
//                                          style: TextStyle(
//                                              fontWeight: FontWeight.w600, color: Color(0xFFFF7643)),
//                                        ),
//                                      )
//                                    ],
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
                      );
                    }else{
                      return Container();
                    }
                  }
                  ).toList(),
                );
              }
          )
        ),
      ):Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
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
          ),
    );
  }
}
