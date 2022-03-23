import 'dart:async';

import 'package:app_restaurant_api/data/model/restau.dart';

import 'package:app_restaurant_api/provider/search_restaurant_provider.dart';
import 'package:app_restaurant_api/utils/state_result.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantSearch extends StatefulWidget {
  static const routeName = 'page_search';

  const RestaurantSearch({Key? key}) : super(key: key);

  @override
  _RestaurantSearchState createState() => _RestaurantSearchState();
}

class _RestaurantSearchState extends State<RestaurantSearch> {
  String queries = '';
  TextEditingController _controller = TextEditingController();

  Widget _listSearch(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, provider, _) {
        if (provider.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.state == ResultState.hasData) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: provider.result?.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = provider.result!.restaurants;
                  return buildListSearch(restaurant[index], index, context);
                }),
          );
        } else if (provider.state == ResultState.noData) {
          return Center(
            child: Text(provider.message),
          );
        } else if (provider.state == ResultState.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Gaga memuat ")],
            ),
          );
        } else {
          return Center(
            child: Text(''),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Timer? _debounce;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Center(
          child: Column(
        children: [
          Consumer<SearchProvider>(
            builder: (context, state, _) {
              return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: ListTile(
                      leading: Icon(
                        Icons.search,
                        size: 30,
                      ),
                      title: TextField(
                        controller: _controller,
                        onChanged: (String value) {
                          setState(() {
                            queries = value;
                          });
                          if (value != '') {
                            state.fetchSearchRestaurant(value);
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Cari Restoran",
                            border: InputBorder.none),
                      ),
                      trailing: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          if (queries != '') {
                            _controller.clear();
                            setState(() {
                              queries = '';
                            });
                          }
                        },
                        icon: Icon(Icons.cancel_outlined, size: 30),
                      )));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: _listSearch(context),
            ),
          ),
        ],
      )),
    );
  }

  Widget buildListSearch(
      Restaurants restaurant, int index, BuildContext context) {
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
                      restaurant.pictureId,
                  width: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
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
                            Text(restaurant.city),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            ),
                            Text(restaurant.rating.toString())
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
