import 'package:app_restaurant_api/data/model/restau.dart';
import 'package:app_restaurant_api/provider/database_provider.dart';
import 'package:app_restaurant_api/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final Restaurants favorite;

  const FavoriteButton({Key? key, required this.favorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(favorite.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return isFavorite
                ? InkWell(
                    onTap: () {
                      provider.removeFavorite(favorite.id);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Remove to Favorite'),
                        duration: Duration(milliseconds: 500),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kBlueColor,
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: Colors.white,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      provider.addFavorite(favorite);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Add to Favorite'),
                          duration: Duration(milliseconds: 500)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kBlueColor,
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.favorite_outline_rounded,
                        color: Colors.white,
                      ),
                    ),
                  );
          },
        );
      },
    );
  }
}
