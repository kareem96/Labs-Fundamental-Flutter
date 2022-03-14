



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/menus.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/widget/platform_widget.dart';

class DetailPage extends StatefulWidget {

  final Restaurant restaurantDetail;
  static const routeName = 'detail_page';
  const DetailPage({Key? key, required this.restaurantDetail}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos);
  }

  Widget _buildDetails(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(tag: widget.restaurantDetail.pictureId, child: Image.network(widget.restaurantDetail.pictureId),),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                const SizedBox(width: 8,),
                Text(widget.restaurantDetail.city),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.restaurantDetail.description),
                _buildMenus(
                    context: context,
                    title: 'Makanan',
                    menus: widget.restaurantDetail.menus.foods),
                _buildMenus(context: context, title: 'Minuman', menus: widget.restaurantDetail.menus.drinks)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenus({required BuildContext context, required String title, required List<Menu> menus}){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8,),
          Container(child: Text(title, style: Theme.of(context).textTheme.headline6,),),
          SizedBox(height: 65,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: menus.length,
                itemBuilder: (context, index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child:  Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(menus[index].name)
                        ],
                      ),
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }

  /// build android
  Widget _buildAndroid(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(widget.restaurantDetail.name),),
      body: _buildDetails(context),
    );
  }
  /// build ios
  Widget _buildIos(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(widget.restaurantDetail.name),),
      body: _buildDetails(context),
    );
  }
}
