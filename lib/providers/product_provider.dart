import 'package:flutter/material.dart';
import 'package:shopping_app/data/dummy_data.dart';
import 'package:shopping_app/providers/products.dart';

class ProductProviders with ChangeNotifier {
  final List<Product> _items = DummyData;

  //var _showFav = false;

  List<Product> get items {
    // if (_showFav) {
    //   return _items.where((product) => product.isFavorite).toList();
    // }
    return [..._items];
  }

  // void showFavOnly(){
  //   _showFav=true;
  //   notifyListeners();
  // }
  // void showAll(){
  //   _showFav=false;
  //   notifyListeners();
  // }
  List<Product> get favItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  void addProducts() {
    //_items.add(value);
    notifyListeners();
  }
}
