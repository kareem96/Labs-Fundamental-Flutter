

import 'package:app_restaurant_api/data/local/database_helper.dart';
import 'package:app_restaurant_api/data/model/restau.dart';
import 'package:app_restaurant_api/utils/state_result.dart';
import 'package:flutter/material.dart';

class DatabaseProvider extends ChangeNotifier{
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}){
    _getFavorite();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurants> _favorite = [];
  List<Restaurants> get favorite => _favorite;

  void _getFavorite() async{
    _favorite = await databaseHelper.getFavorite();
    if(_favorite.length > 0){
      _state = ResultState.hasData;
    }else{
      _state = ResultState.noData;
      _message = 'Empty Favorite';
    }
    notifyListeners();
  }

  void addFavorite(Restaurants restaurants) async{
    try{
      await databaseHelper.insertFavorite(restaurants);
      _getFavorite();
    }catch (e){
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async{
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id)async{
    try{
      await databaseHelper.removeFavorite(id);
      _getFavorite();
    }catch (e){
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}