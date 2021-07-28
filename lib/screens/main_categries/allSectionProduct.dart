import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:souqporsaid/screens/product/product_page.dart';

class AllSectionProduct extends StatefulWidget {
  final String category;
  final String subCategory;
  AllSectionProduct({this.category,this.subCategory});
  @override
  _AllSectionProductState createState() => _AllSectionProductState();
}

class _AllSectionProductState extends State<AllSectionProduct> {
  String searchProduct='';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: Image.asset("assets/appBarLogo.png"),
        centerTitle: true,
        actions: [
          GestureDetector(child: Icon(Icons.search,color: Colors.white,),onTap: (){},),
          SizedBox(width: 10,),
          GestureDetector(child: Icon(Icons.shopping_cart,color: Colors.white,),onTap: (){},),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(12, 10, 8, 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 1,
                      ),
                    ]),
                child: TextFormField(
                  onChanged: (val){
                    setState(() {
                      searchProduct=val;
                    });
                  },
                  enabled: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'أبجث عن منتج داخل تلك الفئة',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.85,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                      color: Colors.white
                  ),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Product").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if (snapshot.hasError) {
                        return  Text('يوجد خطأ في تحميل الفئات',textAlign: TextAlign.center,style: TextStyle(
                            color: Colors.orange
                        ),);
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(color: Colors.orange,));
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                            scrollDirection: Axis.vertical,
                            children:snapshot.data.docs.map<Widget>((document){
                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                              if(data['name'].toString().contains(searchProduct) && data['category']==widget.category && data["subCategory"]== widget.subCategory){
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductPage(product: data,)));
                                  },
                                  child: Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      width: MediaQuery.of(context).size.width*0.9,
                                      height: MediaQuery.of(context).size.height*0.17,
                                      child: Row(
                                        children: [
                                          Expanded(child: Container(
                                            child: Image.network(data['images'][0],fit: BoxFit.contain,),
                                            decoration: BoxDecoration(
                                              color: Colors.orange[100].withOpacity(.2),
                                              borderRadius: BorderRadius.circular(15)
                                            ),
                                            margin: EdgeInsets.all(10),
                                          ),),
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 25,
                                                margin: EdgeInsets.only(left: 110),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.orange
                                                ),
                                                child: Center(
                                                  child: Text("${data["discount"].toString()}%",style: TextStyle(
                                                      color: Colors.white
                                                  ),),
                                                ),
                                              ),
                                              Text(data["name"],textAlign: TextAlign.center,style: TextStyle(
                                                  fontSize: 20
                                              ),),
                                              Text('${data["price"].toString()} EGP',textAlign: TextAlign.center,style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16
                                              ),),
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8.0),
                                                child: RatingBar(
                                                  ignoreGestures: true,
                                                  itemSize: 20,
                                                  allowHalfRating: true,
                                                  initialRating:3,
                                                  itemPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                                  ratingWidget: RatingWidget(
                                                    empty: Icon(
                                                        Icons.star_border,
                                                        color:Colors.grey,
                                                        size: 20),
                                                    full: Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 20,
                                                    ),
                                                    half: null,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),),),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }else{
                                return Container();
                              }
                            }).toList()
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
