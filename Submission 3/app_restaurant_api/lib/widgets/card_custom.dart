import 'package:app_restaurant_api/common/navigation.dart';
import 'package:app_restaurant_api/data/model/restau.dart';
import 'package:app_restaurant_api/provider/database_provider.dart';
import 'package:app_restaurant_api/ui/detail_page.dart';
import 'package:app_restaurant_api/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class CardCustom extends StatefulWidget {
  final String pictureId;
  final String name;
  final String city;
  final double rating;
  final Function() onPress;

  const CardCustom({
    Key? key,
    required this.pictureId,
    required this.name,
    required this.city,
    required this.rating,
    required this.onPress,
  }) : super(key: key);

  @override
  _CardCustomState createState() => _CardCustomState();
}

class _CardCustomState extends State<CardCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        child: InkWell(
          onTap: widget.onPress,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.pictureId,
                    height: 50,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.name),
                      Text(widget.city),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.rating.toString(),
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: medium,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          RatingBar.builder(
                              allowHalfRating: true,
                              ignoreGestures: true,
                              minRating: 1,
                              maxRating: 5,
                              itemCount: 5,
                              itemSize: 14,
                              initialRating: widget.rating,
                              itemBuilder: (context, _) =>
                                  const Icon(Icons.star),
                              onRatingUpdate: (rating) {})
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

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

}
