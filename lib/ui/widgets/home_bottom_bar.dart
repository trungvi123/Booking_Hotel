import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myshop/ui/products/page_index_manager.dart';
import 'package:myshop/ui/products/product_favorite_screen.dart';
import 'package:myshop/ui/products/product_overview_screen.dart';
import 'package:provider/provider.dart';

import '../cart/cart_screen.dart';

class HomeBottomBar extends StatelessWidget {
  HomeBottomBar({super.key});
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: context.watch<PageIndexManager>().pageindex,
        onTap: (value) => {
              if (value == 1)
                {
                  context.read<PageIndexManager>().add(1),
                  Navigator.of(context).pushReplacementNamed('/')
                }
              else if (value == 0)
                {
                  context.read<PageIndexManager>().add(0),
                  Navigator.of(context)
                      .pushNamed(ProductFavoriteScreen.routeName)
                }
              else
                {
                  context.read<PageIndexManager>().add(2),
                  Navigator.of(context).pushNamed(CartScreen.routeName)
                },
            },
        items: const [
          Icon(
            Icons.favorite_outline,
            size: 30,
          ),
          Icon(
            Icons.home,
            size: 30,
          ),
          Icon(
            Icons.shopping_cart_sharp,
            size: 30,
          ),
        ]);
  }
}
