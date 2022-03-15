import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/splash_screen.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.routeName,
      routes: routes
    );
  }
}

final routes = <String, WidgetBuilder>{
  SplashScreen.routeName: (context) => const SplashScreen(),
  HomePage.routeName: (context) => const HomePage(),
  DetailPage.routeName: (context) => DetailPage(restaurantDetail: ModalRoute.of(context)?.settings.arguments as Restaurant,)
};



