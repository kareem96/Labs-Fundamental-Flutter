import 'package:app_restaurant_api/data/api/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])

void main() {
  group('get top headlines', () {
    test('return top headlines if the http call completes successfully', () async {
      final apiService =ApiService();
      final client = MockClient();

      var response = '{"error": false,"message": "success","count": 20, "restaurants": []}';

      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
      .thenAnswer((_) async => http.Response(response, 200));

      var restaurantAct = await apiService.getTopHeadLines(client);
      expect(restaurantAct.message, 'success');
    });
  });
}
