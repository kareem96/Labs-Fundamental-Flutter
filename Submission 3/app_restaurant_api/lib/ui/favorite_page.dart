
import 'package:app_restaurant_api/provider/database_provider.dart';
import 'package:app_restaurant_api/utils/state_result.dart';
import 'package:app_restaurant_api/widgets/card_custom.dart';
import 'package:app_restaurant_api/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  static const String favoriteTitle = 'Favorite';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  /*Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(favoriteTitle),
      ),
      *//*body: _buildList(),*//*
    );
  */}
/*
  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(favoriteTitle),
      ),
      child: _buildList(),
    );
  }*/

  /*Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultStatus.hasData) {
          return ListView.builder(
              itemCount: provider.favorite.length,
              itemBuilder: (context, index){
                return CardCustom(
                    restaurant: provider.favorite[index]
                );
              }
          );
        }else{
          return Center(child: Text(provider.message),);
        }
      },
    );
  }*/

