import 'package:flutter/material.dart';

class ShoppingCart extends ChangeNotifier{
  List<Map> _products=[];
  var _totalPrice=0.0;

  void addItem(Map product){
    _products.add(product);
    _totalPrice+=product['product']["price"] * product["quantity"];
    notifyListeners();
  }

  void removeItem(Map product){
    _products.remove(product);
    _totalPrice-=product['product']["price"] * product["quantity"];
    notifyListeners();
  }
  void clearCart(){
    _products=[];
    _totalPrice=0.0;
    notifyListeners();
  }

  int get count{
    return _products.length;
  }

  double get allTotalPrice{
    return _totalPrice;
  }

  List<Map> get cartProducts{
    return _products;
  }
}