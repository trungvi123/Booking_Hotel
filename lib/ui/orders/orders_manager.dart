import 'package:flutter/foundation.dart';

import '../../models/auth_token.dart';
import '../../models/order.dart';
import '../../services/orders_service.dart';

class OrderManager with ChangeNotifier {
  List<Order> _items = [];

  final OrderService _orderService;

  OrderManager([AuthToken? authToken])
      : _orderService = OrderService(authToken);

  set authToken(AuthToken? authToken) {
    _orderService.authToken = authToken;
  }

  // Order findById(String id) {
  //   return _items.firstWhere((prod) => prod.id == id);
  // }

  Future<void> fetchOrders([bool filterByUser = false]) async {
    _items = await _orderService.fetchOrders(filterByUser);
    notifyListeners();
  }

  // int get itemCount {
  //   return _items.length;
  // }

  // List<Order> get items {
  //   return [..._items];
  // }


  // Order findByOrderId(String id) {
  //   return _items.firstWhere((prod) => prod.id == id);
  // }

  Future<void> addOrder(Order order) async {
    final newOrder = await _orderService.addOrder(order);
    if (newOrder != null) {
      _items.add(newOrder);
      notifyListeners();
    }
  }

  // Future<void> updaterOrder(Order order) async {
  //   final index = _items.indexWhere((item) => item.id == order.id);
  //   if (index >= 0) {
  //     if (await _orderService.updateOrder(order)) {
  //       _items[index] = order;
  //       notifyListeners();
  //     }
  //   }
  // }

  // Future<void> deleteOrder(String id) async {
  //   final index = _items.indexWhere((item) => item.id == id);
  //   Order? existingOrder = _items[index];
  //   _items.removeAt(index);
  //   notifyListeners();

  //   if (!await _orderService.deleteOrder(id)) {
  //     _items.insert(index, existingOrder);
  //     notifyListeners();
  //   }
  // }



  
}
