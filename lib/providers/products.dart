import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.isFavorite = false,
    String? id,
  }) : id = id ?? uuid.v4();

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
