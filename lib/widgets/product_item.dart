import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    // return Consumer<Product>( //other way instead of Provider.of<Product>(context);
    //   builder: (ctx, product, Widget? child) {
        // to clarify we wrap the ClipRRect with the consumer widget and make ClipRRect as a child
        // if we need to redo this simply we can remove the consumer widget and uncomment the upper line
        // reference 180 using-consumer-instead-of-provider-of
        // consumer to make the part you wanna reload we can as well wrap the part that we want to reload only with the consumer widget
        // and set Provider.of<Product>(context,"listen: false");
    final cart = Provider.of<Cart>(context, listen: false);
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            child: GestureDetector(
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute( // route on the fly for each element
                //     builder: (ctx) => ProductDetailScreen(title),
                //   ),
                // );
                Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                    arguments: product.id);
              },
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black87,
              leading: Consumer<Product>( //other way instead of Provider.of<Product>(context);
        builder: (ctx, product, Widget? child) =>(
                IconButton(
                  color: Theme.of(context).accentColor,
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: () {
                    product.toggleFavoriteStatus();
                  },
                )),
              ),
              title: Text(
                product.title,
                textAlign: TextAlign.center,
              ),
              trailing: IconButton(
                onPressed: () {
                  cart.addItem(product.id, product.title, product.price);
                },
                color: Theme.of(context).accentColor,
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        );
  }
//       },
//     );
//   }
}
