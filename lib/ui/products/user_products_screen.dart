import 'package:flutter/material.dart';
import 'package:myshop/ui/products/edit_product_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/post_app_bar.dart';
import 'user_product_list_tile.dart';
import 'products_manager.dart';

import '../shared/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<ProductsManager>().fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    final productsMananger = ProductsManager();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: PostAppBar(false, false)),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refreshProducts(context),
            child: buildUserProductListView(productsMananger),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 150,
        child: IconButton(
          icon: const Icon(Icons.playlist_add_outlined,size: 28),
          onPressed: () {
            Navigator.of(context).pushNamed(
            EditProductScreen.routeName,
          );
          },
        ),
      ),
    );
  }

  Widget buildUserProductListView(ProductsManager productsMananger) {
    return Consumer<ProductsManager>(
      builder: (ctx, productsMananger, child) {
        return ListView.builder(
          itemCount: productsMananger.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProductListTile(
                productsMananger.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
        );
      },
    );
  }
}
