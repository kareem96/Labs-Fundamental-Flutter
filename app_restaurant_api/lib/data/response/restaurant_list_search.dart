


import 'package:app_restaurant_api/data/model/restau.dart';

class RestaurantSearchResponse{
   bool error;
   int founded;
   List<Restaurant> restaurant;

  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurant,});

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) => RestaurantSearchResponse(
    error: json['error'],
    founded: json['founded'],
    restaurant: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'error': error,
    'founded':founded,
    'restaurants':List<dynamic>.from(restaurant.map((x) => x.toJson()))
  };
}