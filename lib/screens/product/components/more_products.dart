import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:souqporsaid/app_properties.dart';
import 'package:souqporsaid/screens/home_page/productTestModel.dart';
import 'package:souqporsaid/screens/product/components/product_card.dart';
import 'package:flutter/material.dart';

class MoreProducts extends StatelessWidget {
  Map<String, dynamic> product;
  MoreProducts({this.product});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 26.0, bottom: 8.0),
          child: Text(
            'منتجات أخري',
            style: TextStyle(color: Colors.black, shadows: shadow),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          height: 250,
          child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Product").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasError) {
                return  Center(
                  child: Text('يوجد خطأ في تحميل الفئات',textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.orange
                  ),),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: Colors.orange,));
              }
              return ListView(
                padding: EdgeInsets.only(left: 15),
                children: snapshot.data.docs.map<Widget>((document){
                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                  if(data['category']==product['category'] && data["subCategory"]== product['subCategory']){
                    return Padding(
                    padding:EdgeInsets.only(right: 10),
                    child: ProductCard(product: data,));
                  }else{
                    return Container();
                  }
                }).toList(),
            scrollDirection: Axis.horizontal,
          );
            },
          )

        )
      ],
    );
  }
}
