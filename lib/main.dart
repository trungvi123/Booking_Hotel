import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myshop/ui/products/product_favorite_screen.dart';

import 'package:provider/provider.dart';

import 'ui/screens.dart';

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
        // Lấy chỉ số trang hiện tại
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
        ChangeNotifierProxyProvider<AuthManager, OrderManager>(
          create: (ctx) => OrderManager(),
          update: (ctx, authMananger, orderManager) {
            orderManager!.authToken = authMananger.authToken;
            return orderManager;
          },
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
            home: authMananger.isAuth
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
              UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
              ProductFavoriteScreen.routeName: (ctx) =>
                  const ProductFavoriteScreen(),
              FormScreen.routeName: (ctx) => const FormScreen(),
              UserScreen.routeName: (ctx) => const UserScreen(),

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

              if (settings.name == ShowImgScreen.routeName) {
                final urlImg = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return ShowImgScreen(urlImg != null ? urlImg : '');
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
