import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souqporsaid/screens/cart/cart_class.dart';
import 'package:souqporsaid/screens/product/components/dialog.dart';
import 'package:souqporsaid/screens/search/search_screen.dart';

import '../../alertToast.dart';
import '../responsize.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String flatNumber;
  String streetAndRegion;
  String countrySection;
  String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(onTap: (){
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        backgroundColor: Colors.black,
        title: Image.asset("assets/appBarLogo.png"),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
        ],
      ),
      body: Consumer<ShoppingCart>(
          builder: (context, cart, child){
            return SingleChildScrollView(
              child: Container(
                padding:AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)?EdgeInsets.all(40):EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color(0xffF8F8F9),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("عنوان الطلب",style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                    //flat and building number
                    SizedBox(height: 20,),
                    TextFormField(
                      onChanged: (val){
                        setState(() {
                          flatNumber=val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "رقم الشقة و العمارة / البرج",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 2
                        ),
                        prefixIcon: Icon(Icons.location_on,color: Colors.grey,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    //street
                    SizedBox(height: 20,),
                    TextFormField(
                      onChanged: (val){
                        setState(() {
                          streetAndRegion=val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "الشارع أو المنطقة",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 2
                        ),
                        prefixIcon: Icon(Icons.location_on,color: Colors.grey,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    //address
                    SizedBox(height: 20,),
                    TextFormField(
                      onChanged: (val){
                        setState(() {
                          countrySection=val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "الحي",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 2
                        ),
                        prefixIcon: Icon(Icons.location_on,color: Colors.grey,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    //phone Number
                    SizedBox(height: 20,),
                    TextFormField(
                      onChanged: (val){
                        setState(() {
                          phoneNumber=val;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "رقم الهاتف",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 2
                        ),
                        prefixIcon: Icon(Icons.phone,color: Colors.grey,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                   GestureDetector(
                     onTap: ()async{
                       SharedPreferences _pref=await SharedPreferences.getInstance();
                        if(phoneNumber!=null && countrySection!=null && flatNumber!=null && streetAndRegion!=null) {
                          if(phoneNumber.length==11){
                            FirebaseFirestore.instance.collection("Order").add({
                              "products":cart.cartProducts,
                              "totalPrice":cart.allTotalPrice,
                              "userName":_pref.getString("userName").toString(),
                              "phoneNumber":phoneNumber,
                              "flatAndBuildingNumber":flatNumber,
                              "countrySection":countrySection,
                              "streetAndRegion":streetAndRegion,
                              "isDone":"false",
                              "userEmail":FirebaseAuth.instance.currentUser.email,
                              "orderTime":DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now()).toString()
                            }).then((val){
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return OrderDialog(
                                    tag: 'assets/assets/icons/done.png',
                                    title: "",
                                    description:
                                    "تم أرسال طلبك",
                                    actionButtonTitle: 'Vist profile',
                                    // TODO: go to servicer provider profile
                                    actionButtonFunction: () =>
                                        print('Navigate to profile'),
                                  );
                                },
                              );
                              cart.clearCart();
                            }).catchError((ex){
                              print("?????????????????????? $ex");
                              alertToast("يوجد خطأ أثناء أرسال طلبك !",Color(0xffFA953D) , Colors.black);
                            });
                          }else{
                            alertToast("أدخل رقم هاتف صالح !",Color(0xffFA953D) , Colors.black);
                          }
                        }else{
                          alertToast("رجاء قم بأدخال كل البيانات !",Color(0xffFA953D) , Colors.black);
                        }
                        },
                     child: Container(
                       margin: EdgeInsets.only(top: 40),
                       width:AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)? MediaQuery.of(context).size.width/2: MediaQuery.of(context).size.width,
                       padding: EdgeInsets.only(top: 10,bottom: 10),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.orange
                       ),
                       child: Center(
                         child: Text("أرسال الطلب",style: TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.bold
                         ),),
                       ),
                     ),
                   )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
