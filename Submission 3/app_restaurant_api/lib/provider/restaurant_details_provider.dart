

import 'dart:io';
import 'dart:async';

import 'package:app_restaurant_api/data/api/api_service.dart';
import 'package:app_restaurant_api/data/response/restaurant_details_response.dart';
import 'package:app_restaurant_api/utils/state_result.dart';
import 'package:flutter/material.dart';

class RestaurantDetailsProvider extends ChangeNotifier{
  late final ApiService apiService;
  String id;

  RestaurantDetailsProvider({required this.apiService, required this.id});

  late RestaurantDetailsResponse _restaurantDetailsResponse;
  RestaurantDetailsResponse get result => _restaurantDetailsResponse;

  String _message = '';
  String get message => _message;

  late ResultState _state;
  ResultState get state => _state;


  Future<dynamic> getDetails(String id) async {
    try{
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.getDetails(id);
      if(restaurants.restaurant.id.isEmpty){
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Not Found Data';
      }else{
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailsResponse = restaurants;
      }
    }catch (e){
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}