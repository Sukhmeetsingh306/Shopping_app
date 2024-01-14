import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/orders.dart';
import 'package:shopping_app/widgets/drawer_app.dart';
import 'package:shopping_app/widgets/oder_items.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return OrderItem(
            order.orders[index],
          );
        },
        itemCount: order.orders.length,
      ),
    );
  }
}
