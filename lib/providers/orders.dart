import 'package:flutter/material.dart';
import 'package:shopping_app/model/cart_item_model.dart';
import 'package:shopping_app/model/order_Item_model.dart';


class Order with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItemModel> cartProduct, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartProduct,
        dateTime: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
