import 'package:flavor_mode/flavor_config.dart';
import 'package:flavor_mode/home_page.dart';
import 'package:flavor_mode/my_app.dart';
import 'package:flutter/material.dart';

void main() {
  FlavorConfig(
      flavor: FlavorType.dev,
      color: Colors.orange,
      values: const FlavorValues(
          titleApp: "Development App"
      )
  );

  runApp(const MyApp());
}