import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myshop/ui/products/product_favorite_screen.dart';

import 'package:provider/provider.dart';

import 'ui/screens.dart';
import 'ui/widgets/form_screen.dart';

Future<void> main() async {
  // (1) Load the .env file
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // (2) Create and provide the AuthManager
        ChangeNotifierProvider(
          create: (context) => PageIndexManager(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
          create: (ctx) => ProductsManager(),
          update: (ctx, authMananger, productsManager) {
            // Khi authMananger có báo hiệu thay đổi  thì đọc lại authToken
            //  cho productsManager
            productsManager!.authToken = authMananger.authToken;
            return productsManager;
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersManager(),
        ),
      ],
      child: Consumer<AuthManager>(
        builder: (ctx, authMananger, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'Lato',
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.purple,
                ).copyWith(
                  secondary: Colors.deepOrange,
                )),
            home:  
              authMananger.isAuth
                ? const ProductsOverviewScreen()
                : FutureBuilder(
                    builder: (ctx, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen();
                    },
                  ),
            routes: {
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => const OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
              ProductFavoriteScreen.routeName: ((ctx) =>
                  const ProductFavoriteScreen()),
            },
            onGenerateRoute: (settings) {
              if (settings.name == ProductDetailScreen.routeName) {
                final productId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return ProductDetailScreen(
                      ctx.read<ProductsManager>().findByProductId(productId),
                    );
                  },
                );
              }

              if (settings.name == EditProductScreen.routeName) {
                final productId = settings.arguments as String?;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return EditProductScreen(
                      productId != null
                          ? ctx
                              .read<ProductsManager>()
                              .findByProductId(productId)
                          : null,
                    );
                  },
                );
              }
              return null;
            },
          );
        },
      ),
      
    );

  }
}
