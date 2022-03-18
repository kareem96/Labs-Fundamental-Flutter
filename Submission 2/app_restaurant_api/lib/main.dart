import 'package:app_restaurant_api/common/navigation.dart';
import 'package:app_restaurant_api/common/style.dart';
import 'package:app_restaurant_api/data/api/api_service.dart';
import 'package:app_restaurant_api/provider/restaurant_details_provider.dart';
import 'package:app_restaurant_api/provider/restaurant_provider.dart';
import 'package:app_restaurant_api/provider/search_restaurant_provider.dart';
import 'package:app_restaurant_api/ui/detail_page.dart';
import 'package:app_restaurant_api/ui/home_page.dart';
import 'package:app_restaurant_api/ui/search_restaurant_page.dart';
import 'package:app_restaurant_api/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Resataurant',
          theme: ThemeData(
              primarySwatch: Colors.grey,
              scaffoldBackgroundColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: myTextTheme,
              appBarTheme: AppBarTheme(titleTextStyle: myTextTheme.headline6)),
          navigatorKey: navigatorKey,
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            HomePage.routeName: (context) => HomePage(),
            RestaurantSearch.routeName: (context) => const RestaurantSearch(),
            RestaurantDetail.routeName: (context) => RestaurantDetail(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as String,
                ),
          },
        ),
      );
}
