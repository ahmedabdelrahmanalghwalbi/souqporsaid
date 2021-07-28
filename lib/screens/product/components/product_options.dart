import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:souqporsaid/app_properties.dart';
import 'package:souqporsaid/screens/home_page/productTestModel.dart';
import 'package:flutter/material.dart';

//import '../../../size_config.dart';
import 'shop_bottomSheet.dart';

class ProductOption extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Map<String, dynamic> product;
  const ProductOption(this.scaffoldKey, {Key key, this.product}) : super(key: key);

  @override
  _ProductOptionState createState() => _ProductOptionState();
}

class _ProductOptionState extends State<ProductOption> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Color(0xffF8F8F9),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      widget.product["rating"].toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(Icons.star,color: Colors.yellow,)
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 238,
            child: AspectRatio(
              aspectRatio: 1,
              child: Hero(
                tag:widget.product["name"],
                child: Image.network(widget.product['images'][selectedImage]),
              ),
            ),
          ),
          // SizedBox(height: getProportionateScreenWidth(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(widget.product['images'].length,
                      (index) => buildSmallProductPreview(index)),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Color(0xFFFF7643).withOpacity(selectedImage == index ? 1.0 : 0)),
        ),
        child: Image.network(widget.product['images'][index]),
      ),
    );
  }
}
