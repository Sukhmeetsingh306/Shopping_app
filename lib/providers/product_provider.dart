import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
//import 'package:shopping_app/data/dummy_data.dart';
import 'package:shopping_app/providers/products.dart';
import 'package:http/http.dart' as http;

class ProductProviders with ChangeNotifier {
  // final List<Product> _items = DummyData;
  late List<Product> _items = [];

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
    return _items.firstWhere(
      (prod) => prod.id == id,
    );
  }

  Future<void> fetchAndAdd() async {
    const url =
        'https://flutter-shopping-b1569-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url as Uri);
      final extractData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];
      extractData.forEach((keyId, valueData) {
        loadedProduct.add(
          Product(
            id: keyId,
            title: valueData['title'],
            description: valueData['description'],
            price: valueData['price'],
            imageUrl: valueData['imageUrl'],
          ),
        );
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    // POST
    const url =
        'https://flutter-shopping-b1569-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        //url,
        Uri.parse(url),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      //     .then((response) {
      //print(json.decode(response.body));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
      );
      _items.add(newProduct);
      //_items.insert(0, newProduct); // when to enter the product at top
      notifyListeners();
    } catch (error) {
      log(error.toString());
      rethrow;
    }
    // }).catchError((error) {
    //   print(error);
    //   throw error;
    // });
  }

  void updateProduct(Product newProduct, String id) {
    final productIndex = _items.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {}
  }

  void deleteProduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}

//15