
import 'package:app_restaurant_api/data/model/restau.dart';

class RestaurantListResponse {
   bool error;
   String message;
   int count;
   List<Restaurants> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) => RestaurantListResponse(
    message: json['message'],
    count: json['count'],
    error: json['error'],
    restaurants: List<Restaurants>.from(
      json['restaurants'].map((x) => Restaurants.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
      'error': error,
      'message': message,
      'count': count,
      'restaurants': List<dynamic>.from(restaurants.map((e) => e.toJson())),
  };
}
