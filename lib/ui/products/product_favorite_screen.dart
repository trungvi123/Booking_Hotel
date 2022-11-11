import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myshop/models/product.dart';
import 'package:myshop/ui/cart/cart_screen.dart';
import 'package:myshop/ui/screens.dart';
import 'package:provider/provider.dart';

import '../widgets/home_app_bar.dart';
import '../widgets/home_bottom_bar.dart';
import './products_grid.dart';

import '../shared/app_drawer.dart';
import 'top_right_badge.dart';

enum FilterOptions { favorites, all }

class ProductFavoriteScreen extends StatefulWidget {
  const ProductFavoriteScreen({super.key});
static const routeName = '/user-products-favorite';
  @override
  State<ProductFavoriteScreen> createState() => _ProductFavoriteScreenState();
}

class _ProductFavoriteScreenState extends State<ProductFavoriteScreen> {
  
  final _showOnlyFavorites = ValueNotifier<bool>(true);

  late Future<void> _fetchProducts;
  var category = [
    'Best Places',
    'Most Visited',
    'Favourites',
    'New Added',
    'Hotels',
    'Restaurants',
  ];

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: HomeAppBar(),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              SizedBox(
                height: 1000,
                child: FutureBuilder(
                    future: _fetchProducts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ValueListenableBuilder<bool>(
                            valueListenable: _showOnlyFavorites,
                            builder: (context, onlyFavorites, child) {
                              return ProductsGrid(onlyFavorites);
                            });
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ],
          ),
        ),
      )),
      bottomNavigationBar: HomeBottomBar(),
    );
  }
}
