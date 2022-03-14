
import 'dart:convert';

import 'menus.dart';

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating'].toDouble(),
      menus: Menus.fromJson(json['menus']));

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': id,
    'description': description,
    'pictureId': pictureId,
    'city': city,
    'rating': rating,
  };
}

/// restaurant mapping
class Restaurants {
  List<Restaurant> restaurants;
  Restaurants({required this.restaurants});

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
    restaurants: List<Restaurant>.from(
        json['restaurants'].map((x) => Restaurant.fromJson(x)))
  );

  Map<String, dynamic> toJson() => {
    'restaurants': List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

Restaurants restaurantsFromJson(String str) => Restaurants.fromJson(json.decode(str));