import 'dart:async';
import 'package:app_restaurant_api/provider/search_restaurant_provider.dart';
import 'package:app_restaurant_api/utils/state_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../widgets/card_custom.dart';
import 'detail_page.dart';

class RestaurantSearch extends StatefulWidget {
  static const routeName = '/page_search';

  const RestaurantSearch({Key? key}) : super(key: key);

  @override
  _RestaurantSearchState createState() => _RestaurantSearchState();
}

class _RestaurantSearchState extends State<RestaurantSearch> {
  String queries = '';
  final TextEditingController _controller = TextEditingController();

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
                  var response = provider.result!.restaurants[index];
                  return CardCustom(
                      pictureId: smallImageUrl + response.pictureId,
                      name: response.name,
                      city: response.city,
                      rating: response.rating,
                      onPress: () {
                        Navigator.pushNamed(context, RestaurantDetail.routeName,
                            arguments: response);
                      });
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
              children: const [
                Icon(Icons.search, size: 70,),
                Text("Restaurant Not Found")
              ],
            ),
          );
        } else {
          return const Center(
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
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        // color: Colors.red[500],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: ListTile(
                      leading: const Icon(
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
                        decoration: const InputDecoration(
                            hintText: "Cari Restoran",
                            border: InputBorder.none),
                      ),
                      trailing: IconButton(
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
}
