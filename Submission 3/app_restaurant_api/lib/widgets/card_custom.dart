


import 'package:app_restaurant_api/common/navigation.dart';
import 'package:app_restaurant_api/data/model/restau.dart';
import 'package:app_restaurant_api/provider/database_provider.dart';
import 'package:app_restaurant_api/ui/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardCustom extends StatefulWidget {
  // final List<Restaurant> restaurant;
  final Restaurant restaurant;
  const CardCustom({Key? key, required this.restaurant}) : super(key: key);

  @override
  _CardCustomState createState() => _CardCustomState();
}

class _CardCustomState extends State<CardCustom> {

  /*Widget _buildItemList(BuildContext context , Restaurant restaurant){
    return Consumer<DatabaseProvider>(
      builder: (context, provider, snapshot){
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot){
            var isFavorited = snapshot.data ?? false;
            return Material(
              child:  ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Hero(
                  tag: restaurant.id,
                  child: Image.network(restaurant.mediumPictureUrl),
                ),
                onTap: () => {
                  Navigation.intentWithData(RestaurantDetail.routeName, restaurant.id),
                },
                title: Text(restaurant.name, overflow: TextOverflow.ellipsis,),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text(restaurant.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Row(
                      children: [
                        Text(restaurant.city)
                      ],
                    ),
                    Row(
                      children: [
                        Text(restaurant.rating.toString()),
                      ],
                    ),
                  ],
                ),
                trailing: isFavorited
                    ? IconButton(onPressed: () => provider.removeFavorite(restaurant.id),
                    color: Theme.of(context).accentColor,
                    icon: Icon(Icons.favorite))
                    : IconButton(onPressed: () => provider.addFavorite(restaurant),
                    color: Theme.of(context).accentColor,
                    icon: Icon(Icons.favorite_border)),
              ),
            );
          },
        );
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, snapshot){
        return FutureBuilder<bool>(
          future: provider.isFavorited(widget.restaurant.id),
          builder: (context, snapshot){
            var isFavorited = snapshot.data ?? false;
            return Material(
              child:  ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Hero(
                  tag: widget.restaurant.id,
                  child: Image.network(widget.restaurant.mediumPictureUrl),
                ),
                onTap: () => {
                  Navigation.intentWithData(RestaurantDetail.routeName, widget.restaurant.id),
                },
                title: Text(widget.restaurant.name, overflow: TextOverflow.ellipsis,),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text(widget.restaurant.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Row(
                      children: [
                        Text(widget.restaurant.city)
                      ],
                    ),
                    Row(
                      children: [
                        Text(widget.restaurant.rating.toString()),
                      ],
                    ),
                  ],
                ),
                trailing: isFavorited
                    ? IconButton(onPressed: () => provider.removeFavorite(widget.restaurant.id),
                    color: Theme.of(context).accentColor,
                    icon: Icon(Icons.favorite))
                    : IconButton(onPressed: () => provider.addFavorite(widget.restaurant),
                    color: Theme.of(context).accentColor,
                    icon: Icon(Icons.favorite_border)),
              ),
            );
          },
        );
      },
    );
    /*return ListView.separated(
        itemCount: widget.restaurant.length,
        separatorBuilder: (context, index){
          return const Divider(height: 2, color: Colors.grey,);
        },
        itemBuilder: (context, index){
          Restaurant restaurant = widget.restaurant[index];
          return _buildItemList(context, restaurant);
        },
    );*/
  }
}
