import 'package:souqporsaid/models/product.dart';
import 'package:souqporsaid/models/user.dart';

class Order {
  Product product;
  int productQuantity;
  String shippingAddress1;
  String shippingAddress2;
  String city;
  String zip;
  String country;
  String phone;
  String status;
  String totalPrice;
  User user;
  String dateOrdered;
  String colors;

  Order(
      {this.product,
        this.productQuantity,
        this.shippingAddress1,
        this.shippingAddress2,
        this.city,
        this.zip,
        this.country,
        this.phone,
        this.status,
        this.totalPrice,
        this.user,
        this.dateOrdered,
        this.colors
      });

  Order.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    productQuantity=json['productQuantity'];
    shippingAddress1 = json['shippingAddress1'];
    shippingAddress2 = json['shippingAddress2'];
    city = json['city'];
    zip = json['zip'];
    country = json['country'];
    phone = json['phone'];
    status = json['status'];
    totalPrice = json['totalPrice'];
    user = json['user'];
    dateOrdered = json['dateOrdered'];
    colors=json['colors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['productQuantity']=this.productQuantity;
    data['shippingAddress1'] = this.shippingAddress1;
    data['shippingAddress2'] = this.shippingAddress2;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['totalPrice'] = this.totalPrice;
    data['user'] = this.user;
    data['dateOrdered'] = this.dateOrdered;
    data['color']=this.colors;
    return data;
  }
}