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
            : productsManager.items
            
            );

    if (products.isEmpty) {
      return Column(
        children: [
          Container(
            height: 500,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://cafebiz.cafebizcdn.vn/thumb_w/600/162123310254002176/2021/8/9/photo1628498917276-1628498917376817005725.jpg'),
                    fit: BoxFit.fitWidth)),
            child: const Center(
              child: Text(
                'Chưa thích sản phẩm nào mà dám dô đây coi hạ???',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    ),
              ),
            ),
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
