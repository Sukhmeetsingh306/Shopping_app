import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/product_provider.dart';

import 'product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavOnly;

  const ProductGrid(this.showFavOnly, {super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProviders>(context);
    final productProvider =
        showFavOnly ? productData.favItems : productData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // want the single photo in a block change 2 to 1
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          //create: (context) => productProvider[index],
          value: productProvider[index],
          child: const ProductItem(
              // productProvider[index].id,
              // productProvider[index].title,
              // productProvider[index].imageUrl,
              ),
        );
      },
      itemCount: productProvider.length,
    );
  }
}
