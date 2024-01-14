import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/product_provider.dart';
import 'package:shopping_app/screens/edit_product_screen.dart';
import 'package:shopping_app/widgets/drawer_app.dart';
import 'package:shopping_app/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});

  static const routeName = '/userScreen';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProviders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users Products',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) => Column(
            children: [
              UserProductItem(
                productData.items[index].title,
                productData.items[index].imageUrl,
              ),
              const Divider(),
            ],
          ),
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}
