import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart.dart';
import 'package:shopping_app/providers/orders.dart';
import 'package:shopping_app/theme/text_theme.dart';
import 'package:shopping_app/widgets/cart_Item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartAmount = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: textStyle(
            22,
            FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total',
                    style: textStyle(
                      20,
                      FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      '₹ ${cartAmount.totalAmount.toStringAsFixed(2)}',
                      style: textStyle(
                        18,
                        FontWeight.w700,
                      ),
                    ),
                    backgroundColor: const Color.fromARGB(255, 243, 243, 243),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CartItem(
                cartAmount.items.values.toList()[index].id,
                cartAmount.items.values.toList()[index].price,
                cartAmount.items.values.toList()[index].quantity,
                cartAmount.items.values.toList()[index].title,
                cartAmount.items.keys.toList()[index],
              ),
              itemCount: cartAmount.items.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<Order>(
                  context,
                  listen: false,
                ).addOrder(
                  cartAmount.items.values.toList(),
                  cartAmount.totalAmount,
                );
                cartAmount.clear();
              },
              child: Text(
                'Order',
                style: textStyle(
                  19,
                  FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

//24
