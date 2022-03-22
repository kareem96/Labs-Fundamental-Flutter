

import 'dart:async';
import 'package:app_restaurant_api/data/api/api_service.dart';
import 'package:app_restaurant_api/data/response/restaurant_list_response.dart';
import 'package:app_restaurant_api/utils/state_result.dart';
import 'package:flutter/material.dart';


class RestaurantProvider extends ChangeNotifier{
  final ApiService apiService;
  RestaurantProvider({required this.apiService}){
    _fetchAllRestaurant();
  }

  String _message = '';
  String get message => _message;

  late ResultState _state;
  ResultState get state => _state;

  late RestaurantListResponse _restaurants;
  RestaurantListResponse get restaurants => _restaurants;




  Future<dynamic> _fetchAllRestaurant() async{
    try{
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getTopHeadLines();
      if(restaurant.restaurants.isEmpty){
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Not Found Data';
      }else{
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurants = restaurant;
      }
    }catch (e){
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}