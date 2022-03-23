import 'package:app_restaurant_api/data/model/drink.dart';
import 'package:app_restaurant_api/data/model/food.dart';
import 'package:app_restaurant_api/data/model/restau.dart';
import 'package:app_restaurant_api/provider/restaurant_details_provider.dart';
import 'package:app_restaurant_api/utils/constants.dart';
import 'package:app_restaurant_api/utils/state_result.dart';
import 'package:app_restaurant_api/utils/theme.dart';
import 'package:app_restaurant_api/widgets/platform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:transparent_image/transparent_image.dart';

import '../widgets/favorite_button.dart';

class RestaurantDetail extends StatefulWidget {
  static const routeName = '/detail_page';
  final Restaurants restaurant;

  const RestaurantDetail({Key? key, required this.restaurant})
      : super(key: key);

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  @override
  void initState() {
    Future.microtask(() {
      RestaurantDetailsProvider provider =
          Provider.of<RestaurantDetailsProvider>(
        context,
        listen: false,
      );
      provider.getDetails(widget.restaurant.id);
    });
    super.initState();
  }

  Widget _buildDetails(BuildContext context) {
    return Scaffold(body: Consumer<RestaurantDetailsProvider>(
      builder: (context, provider, _) {
        if (provider.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.state == ResultState.hasData) {
          final response = provider.result.restaurant;
          final responseFavorite = Restaurants(
              id: response.id,
              name: response.name,
              description: response.description,
              pictureId: response.pictureId,
              city: response.city,
              rating: response.rating);
          return SafeArea(
            child: Stack(
              children: [
                Container(
                  height: 300,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: '${largeImageUrl}${response.pictureId}',
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kBlueColor,
                              ),
                              child: const Icon(
                                Icons.keyboard_backspace,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          FavoriteButton(favorite: responseFavorite)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              response.name,
                              style: blueTextSyle.copyWith(
                                  fontSize: 24, fontWeight: bold),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${response.rating} / 5.0',
                                  style: greyTextStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                RatingBar.builder(
                                    initialRating: response.rating,
                                    allowHalfRating: true,
                                    ignoreGestures: true,
                                    minRating: 1,
                                    maxRating: 5,
                                    itemCount: 5,
                                    itemSize: 20,
                                    itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                    onRatingUpdate: (rating) {})
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 24,
                                  color: kLightGreyColor,
                                ),
                                Text(
                                  '${response.city}',
                                  style: lightGreyTextStyle.copyWith(
                                      fontSize: 18, fontWeight: bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Description'),
                                const SizedBox(
                                  height: 8,
                                ),
                                ReadMoreText(
                                  response.description,
                                  trimLines: 2,
                                  textAlign: TextAlign.justify,
                                  style: lightGreyTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: regular,
                                  ),
                                  trimCollapsedText: 'Read more',
                                  trimExpandedText: 'Collapse',
                                  moreStyle: yellowTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                  lessStyle: yellowTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            const Text('Menus'),
                            const SizedBox(
                              height: 10,
                            ),
                            // _buildDrinkMenu(context, response.menus.foods),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        } else if (provider.state == ResultState.noData) {
          return Center(
            child: Text(''),
          );
        } else if (provider.state == ResultState.error) {
          return Center(
            child: Text(''),
          );
        } else {
          return const SizedBox();
        }
      },
    ));
  }

  Widget _buildFoodMenu(BuildContext context, List<Food> foods) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 65,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Text(foods[index].name)],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildDrinkMenu(BuildContext context, List<Drink> drinks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 65,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: drinks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Text(drinks[index].name)],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return _buildDetails(context);
  }

  Widget _buildIos(BuildContext context) {
    return _buildDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
