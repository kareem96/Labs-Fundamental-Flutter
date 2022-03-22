




import 'dart:async';
import 'dart:io';

import 'package:app_restaurant_api/data/api/api_service.dart';
import 'package:app_restaurant_api/data/model/restau.dart';
import 'package:app_restaurant_api/data/response/restaurant_list_search.dart';
import 'package:app_restaurant_api/ui/search_restaurant_page.dart';
import 'package:app_restaurant_api/utils/state_result.dart';
import 'package:flutter/cupertino.dart';

class SearchProvider extends ChangeNotifier{
  final ApiService apiService;

  SearchProvider({required this.apiService}){
    fetchSearchRestaurant(query);
  }
  String _query = '';
  String get query => _query;

  String _message = '';
  String get message => _message;


  RestaurantSearchResponse? _restaurantResultSearch;
  RestaurantSearchResponse? get result => _restaurantResultSearch;

  ResultState? _state;
  ResultState? get state => _state;


  Future<dynamic> fetchSearchRestaurant(String query) async{
    try{
      _state = ResultState.loading;
      _query = query;

      final restaurantSearch = await apiService.getSearch(query);
      if(restaurantSearch.restaurants.isEmpty){
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Restaurant Tidak dapat ditemukan';
      }else{
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResultSearch = restaurantSearch;
      }
    } catch (e){
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}
