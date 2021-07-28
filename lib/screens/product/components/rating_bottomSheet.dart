import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:souqporsaid/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBottomSheet extends StatefulWidget {
  final Map<String, dynamic> product;
  RatingBottomSheet({this.product});
  @override
  _RatingBottomSheetState createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  double rating = 0.0;
  List<int> ratings = [2, 1, 5, 2, 4, 3];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (b, constraints) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 92,
                        width: 92,
                        decoration: BoxDecoration(
                            color: yellow,
                            shape: BoxShape.circle,
                            boxShadow: shadow,
                            border: Border.all(
                                width: 8.0, color: Colors.white)),
                        child: Image.network(widget.product["images"][0]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 72.0, vertical: 16.0),
                        child: Text(
                          widget.product["name"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            widget.product["rating"].toString(),
                            style: TextStyle(fontSize: 48),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            RatingBar(
                              ignoreGestures: true,
                              itemSize: 20,
                              allowHalfRating: true,
                              initialRating: 1,
                              itemPadding:
                              EdgeInsets.symmetric(horizontal: 4.0),
                              ratingWidget: RatingWidget(
                                empty:Icon(Icons.star_border, color: Colors.grey, size: 24),
                                full: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 24,
                                ),
                                half: null,
                              ),
                            ),
//                                Padding(
//                                  padding: const EdgeInsets.only(top: 4.0),
//                                  child: Text('from 25 people'),
//                                )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Align(
                        alignment: Alignment(0, -1),
                        child: Text('أحدث التعليقات')),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.5,
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("Review").snapshots(),
                        builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if (snapshot.hasError) {
                            return  Center(
                              child: Text('يوجد خطأ في تحميل التقيمات',textAlign: TextAlign.center,style: TextStyle(
                                  color: Colors.orange
                              )),
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator(color: Colors.orange,));
                          }
                          return Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.4,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children:snapshot.data.docs.map<Widget>((document){
                                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                    if(data["productName"]==widget.product["name"] && data['productCategory']==widget.product["category"] && data["productSubCategory"]== widget.product["subCategory"]){
                                      return
                                        Container(
                                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(right: 16.0),
                                                  child: CircleAvatar(
                                                    maxRadius: 14,
                                                    backgroundImage: AssetImage(
                                                        'assets/assets/background.jpg'),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            data["userEmail"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                          Text(
                                                            data["timeStamp"].toString(),
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 10.0),
                                                          )
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.symmetric(
                                                            vertical: 8.0),
                                                        child: RatingBar(
                                                          ignoreGestures: true,
                                                          itemSize: 20,
                                                          allowHalfRating: true,
                                                          initialRating: data["rating"],
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
                                                      Text(
                                                        data["description"],
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ));
                                    }else{
                                      return Container();
                                    }
                                  }).toList()
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
