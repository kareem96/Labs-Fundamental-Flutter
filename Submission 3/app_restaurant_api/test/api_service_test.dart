import 'package:app_restaurant_api/data/api/api_service.dart';
import 'package:app_restaurant_api/data/response/restaurant_list_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([ApiService],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late ApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
  });

  final tesRestaurant = RestaurantListResponse(
    error: false,
    message: 'message',
    count: 0,
    restaurants: [],
  );

  test('get topHeadlines', () async{
    ///arrange
    when(mockApiService.getTopHeadLines()).thenAnswer((_) async => tesRestaurant);
    ///act
    await mockApiService.getTopHeadLines();
    ///assert
    verify(mockApiService.getTopHeadLines());
  });

}
