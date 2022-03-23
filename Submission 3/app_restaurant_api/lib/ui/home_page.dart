import 'package:app_restaurant_api/data/model/restau.dart';
import 'package:app_restaurant_api/provider/restaurant_provider.dart';
import 'package:app_restaurant_api/ui/detail_page.dart';
import 'package:app_restaurant_api/ui/search_restaurant_page.dart';
import 'package:app_restaurant_api/utils/constants.dart';
import 'package:app_restaurant_api/utils/state_result.dart';
import 'package:app_restaurant_api/widgets/card_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/restaurants';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Restaurant"),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(
                context,
                RestaurantSearch.routeName,
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Consumer<RestaurantProvider>(builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                //loading widget
                return const Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.error) {
                // error widget
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/connection.png",
                        width: 50,
                      ),
                      const Text(
                        " Gagal Memuat Data\nHarap Periksa Koneksi Internet kamu",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                );
              } else if (state.state == ResultState.noData) {
                // error No Data
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: state.restaurants.count,
                    itemBuilder: (context, index) {
                      final response = state.restaurants.restaurants[index];
                      return CardCustom(
                          pictureId: smallImageUrl + response.pictureId,
                          name: response.name,
                          city: response.city,
                          rating: response.rating,
                          onPress: () {
                            Navigator.pushNamed(
                                context, RestaurantDetail.routeName,
                                arguments: response);
                          });
                    });
              } else {
                return Text("");
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget buildListItem(Restaurants resto, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2, 1),
              blurRadius: 10,
            ),
          ]),
      child: Stack(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/medium/" +
                      resto.pictureId,
                  width: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resto.name,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.share_location,
                              color: Colors.redAccent[100],
                              size: 20,
                            ),
                            Text(resto.city),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            ),
                            Text(resto.rating.toString())
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
