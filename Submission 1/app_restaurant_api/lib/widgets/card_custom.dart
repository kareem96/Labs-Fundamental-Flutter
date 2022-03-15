


import 'package:app_restaurant_api/common/navigation.dart';
import 'package:app_restaurant_api/data/model/restau.dart';
import 'package:app_restaurant_api/ui/detail_page.dart';
import 'package:flutter/material.dart';

class CardCustom extends StatefulWidget {
  final List<Restaurant> restaurant;
  const CardCustom({Key? key, required this.restaurant}) : super(key: key);

  @override
  _CardCustomState createState() => _CardCustomState();
}

class _CardCustomState extends State<CardCustom> {

  Widget _buildItemList(BuildContext context , Restaurant restaurant){
    return ListTile(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: widget.restaurant.length,
        separatorBuilder: (context, index){
          return const Divider(height: 2, color: Colors.grey,);
        },
        itemBuilder: (context, index){
          Restaurant restaurant = widget.restaurant[index];
          return _buildItemList(context, restaurant);
        },
    );
  }
}
