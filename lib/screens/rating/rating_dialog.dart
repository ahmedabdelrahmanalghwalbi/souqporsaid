import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:souqporsaid/alertToast.dart';
import 'package:souqporsaid/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingDialog extends StatefulWidget {
  final Map<String, dynamic> product;
  RatingDialog({this.product});
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double rating;
  String description;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Widget reviewNow = InkWell(
      onTap: () async {
        if(description!=null && rating!=null){
          FirebaseFirestore.instance.collection("Review").add({
            "userId":FirebaseAuth.instance.currentUser.uid,
            "userEmail":FirebaseAuth.instance.currentUser.email,
            "timeStamp":DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
            "description":description,
            "rating":rating,
            "productName":widget.product["name"],
            "productCategory":widget.product["category"],
            "productSubCategory":widget.product["subCategory"]
          }).then((value){
            Navigator.pop(context);
          }).catchError((ex){
            print(ex);
            alertToast("حدث خطأ أثناء أضافة تقييمك !", Color(0xffFA953D), Colors.black);
          });
        }else{
          alertToast("قم بأضافة تقييمك كاملا !", Color(0xffFA953D), Colors.black);
        }
      },
      child: Container(
        height: 60,
        width: width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("أضافة التعليق",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[50]),
          padding: EdgeInsets.all(24.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              'أكتب تعليقك',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RichText(
                text: TextSpan(
                    style:
                        TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                    children: [

                      TextSpan(
                        text: 'قم بتقيم هذا المنتج ',
                      ),
                      TextSpan(
                          text: widget.product["name"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600])),
                    ]),
              ),
            ),
            RatingBar(
              itemSize: 32,
              allowHalfRating: false,
              initialRating: 1,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              onRatingUpdate: (value) {
              setState(() {
                rating = value;
              });
                print(value);
              },
              ratingWidget: RatingWidget(
                empty:
                    Icon(Icons.star_border, color: Colors.grey, size: 20),
                full: Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 20,
                ),
                half: null,
              ),
            ),
            //description field
            Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextFormField(
                  onChanged: (val){
                    setState(() {
                      description=val;
                    });
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'قل شيئا عن هذا النتج !'),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLength: 100,
                )),
            reviewNow,
          ])),
    );
  }
}
