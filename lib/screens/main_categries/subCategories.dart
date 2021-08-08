import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:souqporsaid/screens/main_categries/allSectionProduct.dart';
import 'package:souqporsaid/screens/search/search_screen.dart';

import '../responsize.dart';
import 'allCategoryProducts.dart';

class SubCategory extends StatefulWidget {
  List<dynamic>subCategories;
  String category;
  String imageUrl;
  SubCategory({this.subCategories,this.category,this.imageUrl});
  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8F9),
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
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.fill
                    )
                  ),
                ),
              ),
              Expanded(flex:1,child: Container(
                decoration: BoxDecoration(
//                  border: Border(bottom: BorderSide(width: 4,color: Colors.grey))
                ),
                child: Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>AllCategoryProducts(category:widget.category)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
//                  height: MediaQuery.of(context).size.height*0.1,
                      padding: EdgeInsets.only(top: 2,bottom: 2,left: 20,right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("عرض كل المنتجات",style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(width: 10,),
                        Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                      ],
                    ),
                  ),
                ),
              ),),),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)?5:3,
                      childAspectRatio:0.9,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)?10:5
                  ),itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllSectionProduct(category: widget.category,subCategory: widget.subCategories[index]['title'],)));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child:CircleAvatar(radius: 70,backgroundColor: Colors.grey,child: Image.network(widget.subCategories[index]['image'],fit: BoxFit.contain,))),
                            Expanded(child: Center(child: Text(widget.subCategories[index]['title'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
//                    fontSize: 16
                              ),
                            ))),
                          ],
                        ),
                      ),
                    );
                  },itemCount: widget.subCategories.length,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
