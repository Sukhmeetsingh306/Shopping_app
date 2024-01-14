import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/products.dart';
import 'package:shopping_app/screens/prod_detail_screen.dart';
import 'package:shopping_app/theme/text_theme.dart';

import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  // final String id;
  // final String title;
  // final String imageUrl;

  // const ProductItem(this.id, this.title, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    );
    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: IconButton(
            onPressed: () {
              product.toggleFavoriteStatus();
            },
            icon: Consumer<Product>(
              builder: (context, product, _) => Icon(
                product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
              ),
            ),
            color: Theme.of(context).canvasColor,
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(
                product.id,
                product.title,
                product.price,
              );
            },
            icon: const Icon(
              Icons.shopping_bag,
            ),
            color: Theme.of(context).canvasColor,
          ),
          backgroundColor: Colors.black87,
          title: SizedBox(
            width: double.infinity,
            child: Text(
              product.title,
              style: textStyle(
                14,
                FontWeight.w300,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => ProductDetailScreen(title),
            //   ),
            // );
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
