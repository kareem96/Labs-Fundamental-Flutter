

import 'dart:convert';
import 'dart:async';

import 'package:app_restaurant_api/data/response/restaurant_details_response.dart';
import 'package:app_restaurant_api/data/response/restaurant_list_response.dart';
import 'package:app_restaurant_api/data/response/restaurant_list_search.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const endpointList = 'list';

  ///get lost restaurant
  Future<RestaurantListResponse> getTopHeadLines(http.Client client) async{
    final response = await client.get(Uri.parse(baseUrl + endpointList));
    try{
      if(response.statusCode == 200){
        return RestaurantListResponse.fromJson(json.decode(response.body));
      }else{
        throw Exception('Failed to load top headlines');
      }
    }catch(e){
      rethrow;
    }
  }

  ///get search
  Future<RestaurantSearchResponse> getSearch(String query) async {
    final response = await http.get(Uri.parse("${baseUrl}search?q=${query}"));
    try{
      if(response.statusCode == 200){
        return RestaurantSearchResponse.fromJson(json.decode(response.body));
      }else{
        throw Exception('Failed to load result search.');
      }
    } on Error {
      rethrow;
    }
  }

  Future<RestaurantDetailsResponse> getDetails(String id) async{
    final response = await http.get(Uri.parse(baseUrl + 'detail/$id')).timeout((const Duration(seconds: 5)));
    try{
      if(response.statusCode == 200){
        return RestaurantDetailsResponse.fromJson(json.decode(response.body));
      }else{
        throw Exception('Failed to load details.');
      }
    }on Error {
      rethrow;
    }
  }
}