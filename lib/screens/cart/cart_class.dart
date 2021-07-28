import 'package:flutter/material.dart';

class ShoppingCart extends ChangeNotifier{
  List<Map> _products=[];
  double _totalPrice=0.0;

  void addItem(Map product){
    _products.add(product);
    _totalPrice+=product['price'];
    notifyListeners();
  }

  void removeItem(Map product){
    _products.remove(product);
    _totalPrice-=product['price'];
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