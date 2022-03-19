import 'package:flavor_mode/home_page.dart';
import 'package:flutter/material.dart';

enum FlavorType {
  dev,
  prod,
}

class FlavorConfig {
  final FlavorType flavor;
  final MaterialColor color;
  final FlavorValues values;

  static FlavorConfig? _instance;

  FlavorConfig({
    this.flavor = FlavorType.dev,
    this.color = Colors.orange,
    this.values = const FlavorValues(),
  }){
   _instance = this ;
  }

  static FlavorConfig get instance => _instance ?? FlavorConfig();
}
