import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/theme/size_box.dart';
import 'package:shopping_app/theme/text_theme.dart';

import '../providers/cart.dart';
import '../providers/product_provider.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  //final String title;

  const ProductDetailScreen({super.key});

  static const routeName = '/productDetailScreen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProductTitle = Provider.of<ProductProviders>(
      context,
      listen: false,
    ).findById(productId);
    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProductTitle.title),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              label: Text(cart.itemCount.toString()),
              child: ch,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_bag,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              child: Image.network(
                loadedProductTitle.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            sizedBox(10, 0),
            Text(
              '₹ ${loadedProductTitle.price}',
              style: textStyle(
                20,
                FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            sizedBox(10, 0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                loadedProductTitle.description,
                textAlign: TextAlign.center,
                style: textStyle(
                  20,
                  FontWeight.w500,
                ),
                softWrap: true,
              ),
            ),
            sizedBox(55, 0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      loadedProductTitle.toggleFavoriteStatus();
                    },
                    icon: Icon(
                      loadedProductTitle.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                    ),
                    label: Text(
                      'Favorite',
                      style: textStyle(
                        18,
                        FontWeight.w500,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      cart.addItem(
                        loadedProductTitle.id,
                        loadedProductTitle.title,
                        loadedProductTitle.price,
                      );
                    },
                    icon: const Icon(Icons.shopping_bag),
                    label: Text(
                      'Add To Cart',
                      style: textStyle(
                        20,
                        FontWeight.w400,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//26