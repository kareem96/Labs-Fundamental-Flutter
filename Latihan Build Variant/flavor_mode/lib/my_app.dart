


import 'package:flavor_mode/flavor_config.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlavorConfig.instance.values.titleApp,
      theme: ThemeData(
        primarySwatch: FlavorConfig.instance.color,
      ),
      home: const HomePage(title: 'Flavor Mode'),
    );
  }
}