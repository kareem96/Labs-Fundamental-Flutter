
import 'package:app_restaurant_api/data/model/restau.dart';

class RestaurantListResponse {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
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
  }
}
