import 'package:souqporsaid/app_properties.dart';
import 'package:souqporsaid/screens/home_page/productTestModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:souqporsaid/screens/search/search_screen.dart';

import 'components/product_display.dart';
import 'view_product_page.dart';

class ProductPage extends StatefulWidget {
  final Map<String, dynamic> product;
  ProductPage({Key key, this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    Widget viewProductButton  = InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ViewProductPage(product: widget.product,))),
      child: Container(
        height: 80,
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
          child: Text("عرض المنتج",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
//      backgroundColor: Color(0xffF8F8F9),
    backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(onTap: (){
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        iconTheme: IconThemeData(color: darkGrey),
        actions: <Widget>[
          IconButton(
              icon: new SvgPicture.asset('assets/assets/icons/search_icon.svg', fit: BoxFit.scaleDown,color: Colors.white,), onPressed: ()=> Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => SearchPage())),)
        ],
        title: Text(
          widget.product['category'],
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18.0),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
        ),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 80.0,
                  ),
                  ProductDisplay(product: widget.product,),
                  SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                    child: Text(
                     widget.product["name"],
                      style: const TextStyle(
                          color:Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child:Container(
                      width: 90,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(253, 192, 84, 1),
                        borderRadius: BorderRadius.circular(4.0),
                        border:
                        Border.all(color: Color(0xFFFFFFFF), width: 0.5),
                      ),
                      child: Center(
                        child: new Text("التفاصيل",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0)),
                      ),
                    )
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, right: 40.0, bottom: 130),
                      child: new Text(
                          widget.product['description'],
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontFamily: "NunitoSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0)))
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(
                    top: 8.0, bottom: bottomPadding != 20 ? 20 : bottomPadding),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                      Color.fromRGBO(255, 255, 255, 0),
                      Color.fromRGBO(253, 192, 84, 0.5),
                      Color.fromRGBO(253, 192, 84, 1),
                    ],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter)),
                width: width,
                height: 120,
                child: Center(
                    child: viewProductButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
