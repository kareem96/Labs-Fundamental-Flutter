

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_provider/done_module_list.dart';
import 'package:state_provider/module_list.dart';
import 'package:state_provider/provider/done_module_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DoneModuleProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> doneModuleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          actions: [
            IconButton(
              key: Key('done_page_button'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              // DoneModuleList(doneModuleList: doneModuleList))
                              DoneModuleList()));
                },
                icon: Icon(Icons.done))
          ],
        ),
        body: ModuleList(
          doneModuleList: doneModuleList,
        ));
  }
}
