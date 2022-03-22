


import 'package:app_restaurant_api/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';
  const SettingsPage({Key? key}) : super(key: key);


  Widget _buildAndroid(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(settingsTitle),),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context){
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  _buildList(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
    );
  }

}
