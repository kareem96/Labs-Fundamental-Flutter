import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_restaurant_api/common/navigation.dart';
import 'package:app_restaurant_api/data/api/api_service.dart';
import 'package:app_restaurant_api/data/local/database_helper.dart';
import 'package:app_restaurant_api/data/model/restau.dart';
import 'package:app_restaurant_api/provider/database_provider.dart';
import 'package:app_restaurant_api/provider/preference_provider.dart';
import 'package:app_restaurant_api/provider/restaurant_details_provider.dart';
import 'package:app_restaurant_api/provider/restaurant_provider.dart';
import 'package:app_restaurant_api/provider/scheduling_provider.dart';
import 'package:app_restaurant_api/provider/search_restaurant_provider.dart';
import 'package:app_restaurant_api/ui/detail_page.dart';
import 'package:app_restaurant_api/ui/favorite_page.dart';
import 'package:app_restaurant_api/ui/home_tab.dart';
import 'package:app_restaurant_api/ui/search_restaurant_page.dart';
import 'package:app_restaurant_api/ui/settings_page.dart';
import 'package:app_restaurant_api/ui/splash_screen.dart';
import 'package:app_restaurant_api/utils/background_service.dart';
import 'package:app_restaurant_api/helper/preference_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializedIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<RestaurantProvider>(
              create: (_) => RestaurantProvider(apiService: _apiService)),
          ChangeNotifierProvider<SearchProvider>(
            create: (_) => SearchProvider(apiService: _apiService),
          ),
          ChangeNotifierProvider<RestaurantDetailsProvider>(
              create: (_) =>
                  RestaurantDetailsProvider(apiService: _apiService)),
          ChangeNotifierProvider<DatabaseProvider>(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
          ),
          ChangeNotifierProvider(
              create: (_) => PreferenceProvider(
                  preferenceHelper: PreferenceHelper(
                      sharedPreferences: SharedPreferences.getInstance()))),
          ChangeNotifierProvider<SchedulingProvider>(
              create: (_) => SchedulingProvider()),
        ],
        child: Consumer<PreferenceProvider>(
          builder: (context, provider, child) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Restaurant',
                theme: provider.themeData,
                builder: (context, child) {
                  return CupertinoTheme(
                      data: CupertinoThemeData(
                        brightness: provider.isDarkTheme
                            ? Brightness.dark
                            : Brightness.light,
                      ),
                      child: Material(
                        child: child,
                      ));
                },
                navigatorKey: navigatorKey,
                initialRoute: SplashScreen.routeName,
                routes: {
                  SplashScreen.routeName: (context) => const SplashScreen(),
                  HomeTab.routeName: (context) => const HomeTab(),
                  FavoritePage.routeName: (context) => const FavoritePage(),
                  RestaurantSearch.routeName: (context) =>
                      const RestaurantSearch(),
                  RestaurantDetail.routeName: (context) => RestaurantDetail(
                        restaurant: ModalRoute.of(context)?.settings.arguments as Restaurants,
                      ),
                  SettingsPage.routeName: (context) => const SettingsPage(),
                });
          },
        ),
      );
}
