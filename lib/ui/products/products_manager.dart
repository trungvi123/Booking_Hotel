import 'package:flutter/foundation.dart';

import '../../models/auth_token.dart';
import '../../models/product.dart';
import '../../services/products_service.dart';

class ProductsManager with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //   isFavorite: true,
    // ),
  ];


  final ProductsService _productsService;

  ProductsManager([AuthToken? authToken])
      : _productsService = ProductsService(authToken);

  set authToken(AuthToken? authToken) {
    _productsService.authToken = authToken;
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    _items = await _productsService.fetchProducts(filterByUser);
    // print(_items);
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findByProductId(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      if (await _productsService.updateProduct(product)) {
        _items[index] = product;
        notifyListeners();
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Product? existingProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _productsService.deleteProduct(id)) {
      _items.insert(index, existingProduct);
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Product product) async {
    final savedStatus = product.isFavorite;
    product.isFavorite = !savedStatus;

    if (!await _productsService.saveFavoriteStatus(product)) {
      product.isFavorite = savedStatus;
    }
  }

  
}
