
import 'package:app_restaurant_api/data/model/restau.dart';

class RestaurantListResponse {
   bool error;
   String message;
   int count;
   List<Restaurant> restaurants;

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
    restaurants: List<Restaurant>.from((json['restaurants'] as List)
        .map((e) => Restaurant.fromJson(e))
        .where((restaurant) =>
          restaurant.id != null &&
          restaurant.name != null &&
          restaurant.description != null &&
          restaurant.address != null &&
          restaurant.city != null &&
          restaurant.pictureId != null)),
  );


  /*factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    final bool error = json['error'];
    final String message = json['message'];
    final int count = json['count'];
    final List<Restaurant> restaurants = (json['restaurants'] as List)
        .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
        .toList();

    return RestaurantListResponse(
      error: error,
      message: message,
      count: count,
      restaurants: restaurants,
    );
  }*/
}
