

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/widget/platform_widget.dart';

import 'detail_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos);
  }
  Widget _buildListHomePage(BuildContext context){
    return FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json'),
        builder:(context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            final List<Restaurant> restaurants = restaurantsFromJson(snapshot.requireData).restaurants;
            return SizedBox(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Restaurant', style: Theme.of(context).textTheme.headline5,),
                    Text('${restaurants.length} Recommendation For You!', style: Theme.of(context).textTheme.headline6,),
                    Expanded(child: ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: (context, index){
                          return _buildListRestaurant(context, restaurants[index]);
                        }
                    ))
                  ],
                ),
              )

            );
          }else if(snapshot.hasError){
            return const Text("Something erro");
          }else{
            return const CircularProgressIndicator();
          }
        }
    );
  }

  Widget _buildListRestaurant(BuildContext context, Restaurant restaurant){
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Card(
          elevation: 5,
          child: ListTile(
            leading: Hero(tag: restaurant.pictureId, child: Image.network(restaurant.pictureId, fit: BoxFit.fill,width: 100,),),
            title: Text(restaurant.name, style: Theme.of(context).textTheme.bodyText2,),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Icon(
                    // Icons.location_on,
                    Icons.location_on,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                const SizedBox(width: 8,),
                Text(restaurant.city),
              ],
            ),
            onTap: (){
              Navigator.pushNamed(context, DetailPage.routeName, arguments: restaurant);
            },
          ),
        ),
      ),
    );
  }

  /// build android
  Widget _buildAndroid(BuildContext context){
    return Scaffold(
      body: _buildListHomePage(context),
    );
  }
  /// build ios
  Widget _buildIos(BuildContext context){
    return Scaffold(
      body: _buildListHomePage(context),
    );
  }


}
