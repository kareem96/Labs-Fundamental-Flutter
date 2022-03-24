

import 'package:app_restaurant_api/data/api/api_service.dart';
import 'package:app_restaurant_api/data/model/restau.dart';
import 'package:app_restaurant_api/data/response/restaurant_list_response.dart';
import 'package:app_restaurant_api/provider/restaurant_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockApiService extends Mock implements ApiService{}

const apiResponse ={
  'error': false,
  'message': 'success',
  'count': 1,
  'restaurants': [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
  ]
};

const testRestaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.2
};


void main(){
  late RestaurantProvider restaurantProvider;
  late ApiService apiService;

  group('Restaurant Provider Test', (){
    setUp((){
      apiService = MockApiService();
      when(apiService.getTopHeadLines()).thenAnswer((_) async => RestaurantListResponse.fromJson(apiResponse));
      restaurantProvider = RestaurantProvider(apiService: apiService);
    });

    test('Verify that fetch all restaurants json parse', () async{
      await restaurantProvider.fetchAllRestaurant();
      var result = restaurantProvider.restaurants.restaurants[0];
      var jsonRestaurant = Restaurants.fromJson(testRestaurant);
      expect(result.id == jsonRestaurant.id, true);
      expect(result.name == jsonRestaurant.name, true);
      expect(result.description == jsonRestaurant.description, true);
      expect(result.pictureId == jsonRestaurant.pictureId, true);
      expect(result.city == jsonRestaurant.city, true);
      expect(result.rating == jsonRestaurant.rating, true);
    });


  });
}