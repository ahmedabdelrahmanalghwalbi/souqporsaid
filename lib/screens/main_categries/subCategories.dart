import 'package:flutter/material.dart';
import 'package:souqporsaid/screens/main_categries/allSectionProduct.dart';

import 'allCategoryProducts.dart';

class SubCategory extends StatefulWidget {
  List<dynamic>subCategories;
  String category;
  SubCategory({this.subCategories,this.category});
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
            children: [
              Expanded(flex:2,child: Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 4,color: Colors.grey))
                ),
                child: Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>AllCategoryProducts(category:widget.category)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
//                  height: MediaQuery.of(context).size.height*0.1,
                      padding: EdgeInsets.only(top: 15,bottom: 15,left: 20,right: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("عرض كل المنتجات",style: TextStyle(
                          color: Colors.orange,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),),
                        Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                      ],
                    ),
                  ),
                ),
              ),),),
              Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio:0.9,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5
                  ),itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllSectionProduct(category: widget.category,subCategory: widget.subCategories[index]['title'],)));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child:CircleAvatar(radius: 70,backgroundColor: Colors.white,child: Image.network(widget.subCategories[index]['image'],))),
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
