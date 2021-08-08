import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:souqporsaid/screens/authentication/signup.dart';
import 'package:souqporsaid/screens/cart/cart_class.dart';
import 'package:souqporsaid/screens/home_page/productTestModel.dart';
import 'package:souqporsaid/screens/product/components/dialog.dart';
import 'package:souqporsaid/screens/product/components/rating_bottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:souqporsaid/screens/rating/rating_page.dart';
import 'package:souqporsaid/screens/search/search_screen.dart';
import '../../app_properties.dart';
import '../responsize.dart';
import 'components/color_list.dart';
import 'components/more_products.dart';
import 'components/product_options.dart';

class ViewProductPage extends StatefulWidget {
  final Map<String, dynamic> product;
  ViewProductPage({Key key, this.product});

  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int quantity=1;
  var selectedColor;
  double totalPrice=0.0;
  var selectedSize;
  int active;
  var chosseColor;

  ///list of product colors
  List<Widget> colors() {
    List<Widget> list = widget.product["colors"];
    for (int i = 0; i < widget.product["colors"].length; i++) {
      list.add(
        InkWell(
          onTap: () {
            setState(() {
              active = i;
              selectedColor=colors()[i];
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Transform.scale(
              scale: active == i ? 1.2 : 1,
              child: Card(
                elevation: 3,
                color: Colors.primaries[i],
                child: SizedBox(
                  height: 32,
                  width: 32,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    Widget description = Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        widget.product['description'],
        maxLines: 5,
        semanticsLabel: '...',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black54),
      ),
    );

    return Consumer<ShoppingCart>(
      builder: (context,cart,child){
        return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0.0,
              iconTheme: IconThemeData(color: darkGrey),
              actions: <Widget>[
                IconButton(
                  icon: new SvgPicture.asset('assets/assets/icons/search_icon.svg', color: Colors.white,fit: BoxFit.scaleDown),
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SearchPage())),
                )
              ],
              leading: GestureDetector(onTap: (){
                Navigator.pop(context);
              },child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
              title: Text(
                widget.product["category"],
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                    fontSize: 18.0),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)?EdgeInsets.only(top: 10,left: 30,right: 30):EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                    color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    ProductOption(
                      _scaffoldKey,
                      product: widget.product,
                    ),
                    //  product Name and add to card button
                    Padding(
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Container(padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
//                                  border: Border.all(color: Colors.black),
                                        color:  Color(0xffF8F8F9)
                                    ),
                                    child: Center(
                                      child: Icon(Icons.add,color: Colors.black,),
                                    ),),
                                  onTap: (){
                                    setState(() {
                                      quantity=quantity+1;
                                    });
                                  },
                                ),
                                Text(quantity.toString(),style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),),
                                GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
//                                  border: Border.all(color: Colors.black),
                                        color:  Color(0xffF8F8F9)
                                    ),
                                    child: Center(
                                      child: Icon(Icons.remove,color: Colors.black,),
                                    ),),
                                  onTap: (){
                                    setState(() {
                                      if(quantity>1){
                                        quantity=quantity-1;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          )),
                          Expanded(child:
                          Container(padding: EdgeInsets.all(10),
                            child: Text(widget.product["name"],textAlign: TextAlign.end,style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),),),)
                        ],
                      ) ,
                    ),

                    //colors row and comments
                    Padding(
                      padding: const EdgeInsets.only(top:20.0,left: 20,right: 20),
                      child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        Flexible(
                          child:SizedBox(
                              height: 75,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      'الألوان',
                                      style: TextStyle(color: Colors.black, shadows: shadow),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:widget.product['colors'].length,
                                      /// list of button colors based on colorList
                                      itemBuilder: (_, index) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            active = index;
                                            chosseColor=widget.product['colors'][index];
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0, vertical: 8.0),
                                          ///scale based on active color
                                          child: Transform.scale(
                                              scale: active == index ? 1.2 : 1,
                                              child: Container(
                                                width: 32,
                                                height: 32,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                                    color: Color(int.parse(widget.product['colors'][index]))
                                                ),
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            if(FirebaseAuth.instance.currentUser==null){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));
                            }else{
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RatingPage(product: widget.product)));
                            }
                          },
                          constraints:
                          const BoxConstraints(minWidth: 45, minHeight: 45),
                          child: Icon(Icons.star,
                              color: Colors.yellow),
                          elevation: 0.0,
                          shape: CircleBorder(),
                          fillColor: Colors.grey[200].withOpacity(.5),
                        ),
                      ]),
                    ),
                    // row of sizes
                    widget.product["sizes"].length!=0?Padding(
                      padding: EdgeInsets.only(top:15,left: 20,right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.06,
                        child: ListView.builder(
                          itemCount: widget.product["sizes"].length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectedSize=widget.product['sizes'][index];
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                padding: EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),
                                child: Center(
                                  child: Text(widget.product['sizes'][index],style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 1
                                  ),textAlign: TextAlign.center,),
                                ),
                                decoration: BoxDecoration(
                                  color:Color(0xffF8F8F9),
                                  borderRadius: BorderRadius.circular(10),
//                            border: Border.all(color: Colors.grey)
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ):Container(),
                    description,
                    MoreProducts(product:widget.product),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: ()async{
                      print("the product quantity $quantity");
                      print("the product select size $selectedSize");
                      print("the product select color ${chosseColor.toString()}");
//                      if(FirebaseAuth.instance.currentUser!=null){
//                        FirebaseFirestore.instance.collection("ShoppingCart").add({
//                          "product":widget.product,
//                          "quantity":quantity,
//                          "size":selectedSize,
//                          "userId":FirebaseAuth.instance.currentUser.uid
//                        }).then((val){
//                          print("shopping cart adding to the user success");
//                        }).catchError((ex){
//                          print("error in adding shopping cart $ex");
//                        });
//                      }else{
//                        Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUp()));
//                      }
                        if(FirebaseAuth.instance.currentUser!=null){
                            cart.addItem({
                              "product":widget.product,
                              "quantity":quantity,
                              "color":chosseColor.toString(),
                              "size":selectedSize
                              });
                            showDialog(
                              context: context,
                              builder: (context) {
                                return OrderDialog(
                                  tag: 'assets/assets/icons/done.png',
                                  title: "",
                                  description:
                                  "تم الأضافة",
                                  actionButtonTitle: 'Vist profile',
                                  // TODO: go to servicer provider profile
                                  actionButtonFunction: () =>
                                      print('Navigate to profile'),
                                );
                              },
                            );
                      }else {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SignUp()));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                            color: Color(0xff00C170),
                            borderRadius: BorderRadius.circular(25)
                        ),
                        width: MediaQuery.of(context).size.width*.7,
                        padding: EdgeInsets.all(10),
                        child: Center(child: Text("أضافة للسلة",style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),)),
                      ),
                    ),

                  ],
                ),
              ),
            ));
      },
    );
  }
}
