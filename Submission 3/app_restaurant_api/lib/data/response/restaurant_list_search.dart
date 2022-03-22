import 'package:app_restaurant_api/data/model/restau.dart';

class RestaurantSearchResponse {
  bool error;
  int founded;
  List<Restaurants> restaurants;

  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResponse(
        error: json['error'],
        founded: json['founded'],
        restaurants: List<Restaurants>.from(
            json["restaurants"].map((x) => Restaurants.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'founded': founded,
        'restaurants': List<dynamic>.from(restaurants.map((x) => x.toJson()))
      };
}
