

import 'package:app_restaurant_api/data/model/restau.dart';
import 'package:app_restaurant_api/ui/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../common/navigation.dart';

class CardArticle extends StatelessWidget {
  final Restaurants restaurants;

  const CardArticle({required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: restaurants.pictureId,
            height: 50,
            width: 70,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          restaurants.name,
        ),
        subtitle: Text(restaurants.description),
        onTap: () =>
            Navigation.intentWithData(RestaurantDetail.routeName, restaurants),
      ),
    );
  }
}