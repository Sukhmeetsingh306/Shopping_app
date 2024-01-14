import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/theme/text_theme.dart';

import '../model/order_Item_model.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  const OrderItem(this.order, {super.key});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  final String id = '';

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      //onDismissed: (direction) {},
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
        margin: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                '\t₹${widget.order.amount}',
              ),
              subtitle: Text(
                DateFormat('dd/MM/yyyy \t hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(
                  _expanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_sharp,
                ),
              ),
            ),
            if (_expanded)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                height: min(
                  widget.order.products.length * 20.0 + 40,
                  180,
                ),
                child: ListView(
                    children: widget.order.products
                        .map(
                          (e) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.title,
                                style: textStyle(
                                  18,
                                  FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${e.quantity} x   ₹${e.price}',
                                style: textStyle(
                                  18,
                                  FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList()),
              )
          ],
        ),
      ),
    );
  }
}
