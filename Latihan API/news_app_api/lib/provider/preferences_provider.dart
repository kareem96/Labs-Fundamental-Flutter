


import 'package:flutter/material.dart';
import 'package:news_app_api/common/styles.dart';
import 'package:news_app_api/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier{

  PreferencesHelper preferencesHelper;
  PreferencesProvider({required this.preferencesHelper});

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyNewsActive = false;
  bool get isDailyNews => _isDailyNewsActive;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;


  void _getTheme() async{
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyNewsPreferences() async{
    _isDailyNewsActive = await preferencesHelper.isDailyNewsActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value){
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableDailyNews(bool value){
    preferencesHelper.setDailyNews(value);
    _getDailyNewsPreferences();
  }
}