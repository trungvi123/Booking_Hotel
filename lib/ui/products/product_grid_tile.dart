import 'package:flutter/material.dart';
import 'package:myshop/ui/cart/cart_manager.dart';
import 'package:myshop/ui/products/products_manager.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';

import './product_detail_screen.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect( 
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: buildGridFooterBar(context),
        child: GestureDetector(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ProductDetailScreen.routeName,
                  arguments: product.id,
                );
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                    opacity: 0.8,
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget buildGridFooterBar(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.blueGrey[100],
      leading: ValueListenableBuilder<bool>(
        valueListenable: product.isFavoriteListenable,
        builder: (ctx, isFavorite, child) {
          return IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              context.read<ProductsManager>().toggleFavoriteStatus(product);
            },
          );
        },
      ),
      title: Text(
        product.title,
        textAlign: TextAlign.center,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.add_shopping_cart,
        ),
        onPressed: () {
          final cart = context.read<CartManager>();
          cart.addItem(product);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: const Text(
                  'Thêm sản phẩm vào giỏ thành công!',
                ),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Hủy',
                  onPressed: () {
                    cart.removeSingleItem(product.id!);
                  },
                ),
              ),
            );
        },
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
