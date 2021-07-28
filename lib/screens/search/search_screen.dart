import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:souqporsaid/app_properties.dart';
import 'package:souqporsaid/screens/home_page/productTestModel.dart';
import 'package:souqporsaid/screens/product/product_page.dart';
import 'package:souqporsaid/screens/product/view_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rubber/rubber.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  String selectedPeriod;
  String selectedCategory="";
  int selectedPrice=100000;
  String searchProduct="";
  List<String> timeFilter = [
    'Brand',
    'New',
    'Latest',
    'Trending',
    'Discount',
  ];

  List<String> categoryFilter = [
    'Skull Candy',
    'Boat',
    'JBL',
    'Micromax',
    'Seg',
  ];

  List<int> priceFilter = [
    100,
    200,
    300,
    400,
    500,
    1000
  ];

  List<Product> searchResults = [];

  TextEditingController searchController = TextEditingController();

  RubberAnimationController _controller;

  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        halfBoundValue: AnimationControllerValue(percentage: 0.4),
        upperBoundValue: AnimationControllerValue(percentage: 0.4),
        lowerBoundValue: AnimationControllerValue(pixel: 50),
        duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _expand() {
    _controller.expand();
  }

  Widget _getLowerLayer() {
    return Container(
      margin: const EdgeInsets.only(top: kToolbarHeight),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'البحث',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CloseButton()
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
                border:
                Border(bottom: BorderSide(color: Colors.orange, width: 1))),
            child: TextField(
              controller: searchController,
              onChanged:(val){
                setState(() {
                  searchProduct=val;
                });
              },
              cursorColor: darkGrey,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  prefixIcon: SvgPicture.asset('assets/assets/icons/search_icon.svg', fit: BoxFit.scaleDown,),
                  suffix: FlatButton(
                      onPressed: () {
                        searchController.clear();
                        searchResults.clear();
                      },
                      child: Text(
                        'Clear',
                        style: TextStyle(color: Colors.red),
                      ))),
            ),
          ),
          Flexible(
            child: Container(
              color: Colors.orange[50],
              child:StreamBuilder(
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
                  return ListView(
                    children:snapshot.data.docs.map<Widget>((document){
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      if(data["name"].toString().contains(searchProduct) && data["category"].toString().contains(selectedCategory) && data['price'] < selectedPrice){
                        return  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListTile(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductPage(product: data,)));
                        },
                        title: Text(data["name"]),
                      ));
                      }else{
                        return Container();
                      }
                    }).toList()
                  );
                },
              )
            ),
          )
        ],
      ),
    );
  }

  Widget _getUpperLayer() {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(0, -3),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24)),
          color: Colors.white),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
//          controller: _scrollController,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Filters',
                  style: TextStyle(color: Colors.black),
                ),
                Icon(Icons.arrow_upward,color: Colors.black,)
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding:
              const EdgeInsets.only(right: 32.0, top: 16.0, bottom: 16.0),
              child: Text(
                'الترتيب من خلال',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 50,
            child:StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Category").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if (snapshot.hasError) {
                  return  Text('يوجد خطأ في تحميل الفئات',textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.orange
                  ),);
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.orange,));
                }
                return ListView(
                  scrollDirection: Axis.horizontal,
                    children:snapshot.data.docs.map<Widget>((document){
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        return Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = data["name"];
                                    });
                                  },
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 20.0),
                                      decoration: selectedCategory ==
                                          data["name"]
                                          ? BoxDecoration(
                                          color: Color(0xffFDB846),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(45)))
                                          : BoxDecoration(),
                                      child: Text(
                                        data["name"],
                                        style: TextStyle(fontSize: 16.0),
                                      ))),
                            ));
                    }).toList()
                );
              },
            )

          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedPrice =priceFilter[index];
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 20.0),
                            decoration: selectedPrice == priceFilter[index]
                                ? BoxDecoration(
                                color: Color(0xffFDB846),
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)))
                                : BoxDecoration(),
                            child: Text(
                              '> ${priceFilter[index].toString()}',
                              style: TextStyle(fontSize: 16.0),
                            ))),
                  )),
              itemCount: priceFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
            body: RubberBottomSheet(
              lowerLayer: _getLowerLayer(), // The underlying page (Widget)
              upperLayer: _getUpperLayer(), // The bottomsheet content (Widget)
              animationController: _controller, // The one we created earlier
            )),
      ),
    );
  }
}
