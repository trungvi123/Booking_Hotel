import 'package:flutter/foundation.dart';

class Product {
  final String? id;
  final String title;
  final String description;
  final double price;

  final int bedroom;
  final int bathroom;
  final int quantityPerson;
  final List types;

  final String imageUrl;
  final String imageUrl2;
  final String imageUrl3;
  final String imageUrl4;

  final ValueNotifier<bool> _isFavorite;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.bedroom,
    required this.bathroom,
    required this.quantityPerson,
    required this.types,
    required this.imageUrl,
    required this.imageUrl2,
    required this.imageUrl3,
    required this.imageUrl4,

    isFavorite = false,
  }) : _isFavorite = ValueNotifier(isFavorite);

  set isFavorite(bool newValue) {
    _isFavorite.value = newValue;
  }

  bool get isFavorite {
    return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavoriteListenable {
    return _isFavorite;
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    int? bathroom,
    int? bedroom,
    int? quantityPerson,
    List? types,
    String? imageUrl,
    String? imageUrl2,
    String? imageUrl3,
    String? imageUrl4,

    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      bathroom: bathroom ?? this.bathroom,
      bedroom: bedroom ?? this.bedroom,
      quantityPerson: quantityPerson ?? this.quantityPerson,
      types: types ?? this.types,
      imageUrl: imageUrl ?? this.imageUrl,
      imageUrl2: imageUrl2 ?? this.imageUrl2,
      imageUrl3: imageUrl3 ?? this.imageUrl3,
      imageUrl4: imageUrl4 ?? this.imageUrl4,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'bedroom': bedroom,
      'bathroom': bathroom,
      'quantityPerson': quantityPerson,
      'types': types,
      'imageUrl': imageUrl,
      'imageUrl2': imageUrl2,
      'imageUrl3': imageUrl3,
      'imageUrl4': imageUrl4,

    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      bathroom: json['bathroom'],
      bedroom: json['bedroom'],
      quantityPerson: json['quantityPerson'],
      types: json['types'],
      imageUrl: json['imageUrl'],
      imageUrl2: json['imageUrl2'],
      imageUrl3: json['imageUrl3'],
      imageUrl4: json['imageUrl4'],

    );
  }
}
