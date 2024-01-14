// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart.dart';
import 'package:shopping_app/theme/text_theme.dart';

import '../providers/product_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String productId;

  const CartItem(this.id, this.price, this.quantity, this.title, this.productId,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final loadedProductTitle = Provider.of<ProductProviders>(
      context,
      listen: false,
    ).findById(productId);
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (direction) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(productId);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.delete_forever,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                loadedProductTitle.imageUrl,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              ListTile(
                leading: CircleAvatar(
                  child: FittedBox(
                    child: Text(
                      '₹$price',
                      style: textStyle(
                        18,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                title: Text(title),
                subtitle: Text('Total: ₹${(quantity * price)}'),
                trailing: Text('$quantity x'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
