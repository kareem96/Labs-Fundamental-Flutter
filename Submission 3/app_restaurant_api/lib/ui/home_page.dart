import 'package:app_restaurant_api/provider/restaurant_provider.dart';
import 'package:app_restaurant_api/ui/detail_page.dart';
import 'package:app_restaurant_api/ui/search_restaurant_page.dart';
import 'package:app_restaurant_api/utils/constants.dart';
import 'package:app_restaurant_api/utils/state_result.dart';
import 'package:app_restaurant_api/widgets/card_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/theme.dart';

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
                    children: const [
                      Icon(Icons.wifi_off, size: 50,),
                      Text('Gagal Memuat Data\nHarap Periksa Koneksi Internet kamu',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                      ),)
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
                return const Text("");
              }
            }),
          ),
        ],
      ),
    );
  }
}
