import 'package:flutter/foundation.dart';

class Order {
  final String? id;
  final String name;
  final String numberphone;
  final String email;
  final String note;
  final String product;

  Order({
    this.id,
    required this.name,
    required this.numberphone,
    required this.email,
    required this.note,
    required this.product,
  });

  Order copyWith({
    String? id,
    String? name,
    String? numberphone,
    String? email,
    String? note,
    String? product,
  }) {
    return Order(
      id: id ?? this.id,
      name: name ?? this.name,
      numberphone: numberphone ?? this.numberphone,
      email: email ?? this.email,
      note: note ?? this.note,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'numberphone': numberphone,
      'email': email,
      'note': note,
      'product': product,
    };
  }

  static Order fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      name: json['name'],
      numberphone: json['numberphone'],
      email: json['email'],
      note: json['note'],
      product: json['product'],
    );
  }
}
