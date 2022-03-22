


import 'package:app_restaurant_api/data/model/restau.dart';

class RestaurantDetailsResponse{
  bool error;
  String message;
  Restaurants restaurant;

  RestaurantDetailsResponse({
    required this.error,
    required this.message,
    required this.restaurant
  });

  factory RestaurantDetailsResponse.fromJson(Map<String, dynamic> json) => RestaurantDetailsResponse(
      error: json['error'],
      message: json['message'],
      restaurant: Restaurants.fromJson(json['restaurant']),
  );

  Map<String, dynamic> toJson() => {
    'error': error,
    'message': message,
    'restaurant': restaurant.toJson(),
  };
}