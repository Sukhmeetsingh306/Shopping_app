import 'package:flutter/material.dart';

import '../model/cart_item_model.dart';

class Cart with ChangeNotifier {
  Map<String, CartItemModel> _items = {};

  Map<String, CartItemModel> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    String title,
    double price,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingValue) => CartItemModel(
          id: existingValue.id,
          title: existingValue.title,
          quantity: existingValue.quantity + 1,
          price: existingValue.price,
        ),
      );
    } else {
      // adding new item
      _items.putIfAbsent(
        productId,
        () => CartItemModel(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void undo(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (value) => CartItemModel(
          id: value.id,
          title: value.title,
          quantity: value.quantity - 1,
          price: value.price,
        ),
      );
    } else {
      // quantity = 1
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
