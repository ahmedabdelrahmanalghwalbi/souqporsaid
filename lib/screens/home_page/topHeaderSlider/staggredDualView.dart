import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:souqporsaid/screens/home_page/topHeaderSlider/productItem.dart';

class StaggeredDualView extends StatefulWidget {
  final double spacing;
  final double aspectRatio;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  StaggeredDualView({this.snapshot,this.spacing=0.0,this.aspectRatio=0.5});

  @override
  _StaggeredDualViewState createState() => _StaggeredDualViewState();
}

class _StaggeredDualViewState extends State<StaggeredDualView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      final width=constraints.maxWidth;
      final height=constraints.maxHeight;
      return  OverflowBox(
        maxWidth: width,
        maxHeight: height,
        minWidth: width,
        minHeight: height,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: widget.aspectRatio,
            crossAxisSpacing: widget.spacing,
            mainAxisSpacing: widget.spacing
        ),
          children:widget.snapshot.data.docs.map<Widget>((DocumentSnapshot document){
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
             return ProductItem(
                product:data,
            );
          }).toList(),
        ),
      );
    });
  }
}


/*
*  itemBuilder:(context,index){
          return Transform.translate(offset: Offset(0.0,index.isOdd?100.0:0.0),
            child: widget.itemBuilder(context,index),
          );
        },itemCount: widget.itemCount,*/