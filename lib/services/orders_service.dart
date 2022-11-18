import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/order.dart';
import '../models/auth_token.dart';
import 'firebase_service.dart';


class OrderService extends FirebaseService {
  
  OrderService([AuthToken? authToken]) : super(authToken);

  Future<List<Order>> fetchOrders([bool filterByUser = false]) async {
    final List<Order> orders = [];
    try {
      final filters =
          filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final orderUrl =
          Uri.parse('$databaseUrl/order.json?auth=$token&$filters');

      final response = await http.get(orderUrl);
      final ordersMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(ordersMap['error']);
        return orders;
      }
     
      return orders;
    } catch (error) {
      print(error);
      return orders;
    }
  }

  Future<Order?> addOrder(Order order) async {
    try {
      final url = Uri.parse('$databaseUrl/order.json?auth=$token'); 
      final response = await http.post(
        url,
        body: json.encode(
          order.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      );
      if (response.statusCode != 200) {
        print(json.decode(response.body));
        throw Exception(json.decode(response.body)['error']);
      }

      return order.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateOrder(Order order) async {
    try {
      final url =
          Uri.parse('$databaseUrl/order/${order.id}.json?auth=$token');
      final response = await http.patch(
        url,
        body: json.encode(order.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteOrder(String id) async {
    try {
      final url = Uri.parse('$databaseUrl/order/$id.json?auth=$token');
      final response = await http.delete(url);
      
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  
}
