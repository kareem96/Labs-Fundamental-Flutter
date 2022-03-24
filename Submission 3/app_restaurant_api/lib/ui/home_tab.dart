import 'dart:io';

import 'package:app_restaurant_api/ui/detail_page.dart';
import 'package:app_restaurant_api/ui/home_page.dart';
import 'package:app_restaurant_api/ui/settings_page.dart';
import 'package:app_restaurant_api/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/notification_helper.dart';
import 'favorite_page.dart';

class HomeTab extends StatefulWidget {
  static const routeName = '/home_tab';

  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _bottomNavIndex = 0;
  static const String _headlineText = 'Home';
  final NotificationHelper _notificationHelper = NotificationHelper();
  final List<Widget> _listWidget = [
    HomePage(),
    FavoritePage(),
    SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
      label: _headlineText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.square_favorites_alt : Icons.favorite),
      label: 'Favorite'
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: SettingsPage.settingsTitle,

    ),
  ];

  void _onBottomNavTapped(int index){
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context){
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context){
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: _bottomNavBarItems,
        ),
        tabBuilder: (context, index){
          return _listWidget[index];
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
    );
  }

  @override
  void initState(){
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(RestaurantDetail.routeName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    selectNotificationSubject.close();
  }
}
