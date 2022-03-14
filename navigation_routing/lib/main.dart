import 'package:flutter/material.dart';
import 'package:navigation_routing/first_screen.dart';
import 'package:navigation_routing/replacement_screen.dart';
import 'package:navigation_routing/screen_another.dart';
import 'package:navigation_routing/screen_return_data.dart';
import 'package:navigation_routing/screen_with_data.dart';
import 'package:navigation_routing/second_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/secondScreen': (context) => SecondScreen(),
        '/screenWithData': (context) => ScreenWithData(ModalRoute.of(context)?.settings.arguments as String),
        '/screenReturnData': (context) => ScreenReturnData(),
        '/screenReplacement': (context) => ScreenReplacement(),
        '/screenAnother': (context) => AnotherScreen(),
      },
    );
  }
}
