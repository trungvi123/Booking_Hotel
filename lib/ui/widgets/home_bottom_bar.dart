import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myshop/ui/auth/auth_manager.dart';
import 'package:myshop/ui/products/mix.dart';
import 'package:myshop/ui/products/product_favorite_screen.dart';
import 'package:myshop/ui/user/user_screen.dart';
import 'package:provider/provider.dart';
import '../cart/cart_screen.dart';
import '../products/user_products_screen.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});
  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AuthManager>().authToken!.userId;
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
              else if (value == 2)
                {
                  context.read<PageIndexManager>().add(2),
                  Navigator.of(context).pushNamed(CartScreen.routeName)
                }
              else if (value == 3)
                {
                  context.read<PageIndexManager>().add(3),
                  if (userId == 'dYh6xo9XwzRQN5ZlqEoCymqr5Hk1')
                    {
                      Navigator.of(context)
                          .pushNamed(UserProductsScreen.routeName)
                    }
                  else
                    {Navigator.of(context).pushNamed(UserScreen.routeName)}
                }
              else
                {
                  context.read<PageIndexManager>().add(4),
                  Navigator.of(context).pushNamed(UserScreen.routeName)
                }
            },
        items: [
          const Icon(
            Icons.favorite_outline,
            size: 30,
          ),
          const Icon(
            Icons.home,
            size: 30,
          ),
          const Icon(
            Icons.shopping_cart_sharp,
            size: 30,
          ),
          if (userId == 'dYh6xo9XwzRQN5ZlqEoCymqr5Hk1')
            const Icon(
              Icons.post_add_rounded,
              size: 30,
            ),
          const Icon(
            Icons.person,
            size: 30,
          ),
        ]);
  }
}
