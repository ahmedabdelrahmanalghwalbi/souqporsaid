import 'package:flutter/material.dart';
import 'package:souqporsaid/screens/cart/cart.dart';
import 'package:souqporsaid/screens/favorite/favorite_screen.dart';
import 'package:souqporsaid/screens/feeds/feeds.dart';
import 'package:souqporsaid/screens/home_page/home_screen.dart';
import 'package:souqporsaid/screens/main_categries/mainCategories.dart';
import 'package:souqporsaid/screens/search/search_screen.dart';
import 'package:souqporsaid/screens/user_info/user_info.dart';

class CustomBottomBar extends StatefulWidget {
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  List _pages=[];
  int selectedPageIndex=0;

  @override
  void initState() {
    super.initState();
    _pages=[
      {'page':HomePage()},
      {'page':FavoriteScreen()},
      {'page':MainCategories()},
      {'page':Cart()},
      {'page':UserInfo()}
    ];
  }

  void selectedPage(int index){
    setState(() {
      selectedPageIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height =MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[selectedPageIndex]["page"],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0.1,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: height*0.08,
          color: Colors.white,
          child: Container(
            decoration:BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5
                )
              )
            ),
            child: BottomNavigationBar(
              onTap: selectedPage,
              backgroundColor: Colors.yellow,
              selectedItemColor: Color(0xffFC9803),
              unselectedItemColor: Colors.black,
              currentIndex: selectedPageIndex,
              items: [
                BottomNavigationBarItem(icon:Icon(Icons.home),label: ""),
                BottomNavigationBarItem(icon:Icon(Icons.favorite),label: ""),
                BottomNavigationBarItem(icon:Icon(null),activeIcon: null,label: ""),
                BottomNavigationBarItem(icon:Icon(Icons.shopping_cart),label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.person_outline),label: ""),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(0.8),
        child: FloatingActionButton(
          hoverElevation: 10,
          backgroundColor: Color(0xffFC9803),
          splashColor: Colors.grey,
          tooltip: "Search",
          elevation: 4,
          child: Icon(Icons.category),
          onPressed: (){
            setState(() {
              selectedPageIndex =2;
            });
//          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainCategories()));
          },
        ),
      )
    );
  }
}
