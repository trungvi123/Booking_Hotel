import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import './product_grid_tile.dart';
import './products_manager.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;

  const ProductsGrid(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    // Đọc ra danh sách các product sẽ được hiển thị từ ProductsManager
    final products = context.select<ProductsManager, List<Product>>(
        (productsManager) => showFavorites
            ? productsManager.favoriteItems
            : productsManager.items);

    if (products.isEmpty && showFavorites) {
      return Container(
        alignment: Alignment.topCenter,
        height: 500,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/likeBg.jpg'), fit: BoxFit.fitWidth)),
      );
    } else if (products.isEmpty && !showFavorites) {
      return Column(
        children: [
          Container(
            height: 500,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/oopsBg.jpg'),
                    fit: BoxFit.fitWidth)),
          ),
        ],
      );
    } else {
      return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ProductGridTile(products[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, mainAxisSpacing: 20),
      );
    }
  }
}
