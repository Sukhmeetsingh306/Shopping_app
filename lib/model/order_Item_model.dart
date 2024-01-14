// ignore_for_file: file_names



import 'package:shopping_app/model/cart_item_model.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItemModel> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}
