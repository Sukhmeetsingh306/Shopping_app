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

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
    );
    _items.add(newProduct);
    //_items.insert(0, newProduct); // when to enter the product at top
    notifyListeners();
  }

  void updateProduct(Product newProduct, String id) {
    final productIndex = _items.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    }else{}
  }

  void deleteProduct(String id){
    _items.removeWhere((product) => product.id== id);
    notifyListeners();
  }
}
