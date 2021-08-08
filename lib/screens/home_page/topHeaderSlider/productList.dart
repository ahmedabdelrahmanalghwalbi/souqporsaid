import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:souqporsaid/screens/authentication/signup.dart';
import 'package:souqporsaid/screens/product/view_product_page.dart';

import '../../../alertToast.dart';
import '../../responsize.dart';
import '../productTestModel.dart';

class ProductList extends StatefulWidget {
  String collectionName;


  ProductList({ this.collectionName});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final SwiperController swiperController = SwiperController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.collectionName==null)
      widget.collectionName = 'MostSellingProducts';
  }
  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height/2.7;
    double cardWidth = MediaQuery.of(context).size.width/1.8;
    if(widget.collectionName==null)
      widget.collectionName = 'MostSellingProducts';
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(widget.collectionName).limit(5).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError) {
          return  Text('يوجد خطأ في تحميل الفئات',textAlign: TextAlign.center,style: TextStyle(
              color: Colors.orange
          ),);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.orange,));
        }
        return SizedBox(
          height: cardHeight,
          child: Swiper(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (_, index) {
              return ProductCard(
                  height: cardHeight,
                  width:AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)?MediaQuery.of(context).size.width*.3: cardWidth,
                  product: snapshot.data.docs[index].data()
              );
            },
            scale: 0.8,
            controller: swiperController,
            viewportFraction: 0.6,
            loop: false,
            fade: 0.5,
            pagination: SwiperCustomPagination(
              builder: (context, config) {
                if (config.itemCount > 20) {
                  print(
                      "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
                }
                Color activeColor = Colors.orange;
                Color color = Colors.grey[300];
                double size = 10.0;
                double space = 5.0;

                if (config.indicatorLayout != PageIndicatorLayout.NONE &&
                    config.layout == SwiperLayout.DEFAULT) {
                  return new PageIndicator(
                    count: config.itemCount,
                    controller: config.pageController,
                    layout: config.indicatorLayout,
                    size: size,
                    activeColor: activeColor,
                    color: color,
                    space: space,
                  );
                }

                List<Widget> dots = [];

                int itemCount = config.itemCount;
                int activeIndex = config.activeIndex;

                for (int i = 0; i < itemCount; ++i) {
                  bool active = i == activeIndex;
                  dots.add(Container(
                    key: Key("pagination_$i"),
                    margin: EdgeInsets.all(space),
                    child: ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: active ? activeColor : color,
                        ),
                        width: size,
                        height: size,
                      ),
                    ),
                  ));
                }

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: dots,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class ProductCard extends StatefulWidget {
  final Map product;
  final double height;
  final double width;

  const ProductCard({this.product,this.height,this.width});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isRed = false;
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProductPage(product: widget.product,)));
      } ,
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 30),
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: Colors.orange,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed:()async{
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
                  color: Colors.white,
                ),
                Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.product["name"] ?? '',
                            style:
                            TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 12.0, 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Color.fromRGBO(224, 69, 10, 1),
                        ),
                        child: Text(
                          'EGP${widget.product["price"] ?? 0.0}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
              child: Image.network(
                widget.product["images"][0] ?? '',
                height: widget.height/1.7,
                width: widget.width/1.4,
                fit: BoxFit.contain,
              ),
          ),
        ],
      ),
    );
  }
}
