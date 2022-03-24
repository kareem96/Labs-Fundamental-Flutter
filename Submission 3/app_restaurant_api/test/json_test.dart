


import 'package:app_restaurant_api/data/model/restau.dart';
import 'package:flutter_test/flutter_test.dart';

var tesRestaurant ={
  "id": "s1knt6za9kkfw1e867",
  "name": "Kafe Kita",
  "description":
  "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
  "pictureId": "25",
  "city": "Gorontalo",
  "rating": 4
};
void main(){
  test('test parsing', () async{
    var result = Restaurants.fromJson(tesRestaurant).id;
    expect(result, 's1knt6za9kkfw1e867');
  });
}