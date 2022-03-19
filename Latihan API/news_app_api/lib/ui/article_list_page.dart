import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_api/provider/news_provider.dart';
import 'package:news_app_api/widgets/card_article.dart';
import 'package:news_app_api/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

import '../data/api/api-service.dart';

import '../utils/result_state.dart';


/*
 new added state provider
*/
class ArticleListPage extends StatelessWidget {

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /*ElevatedButton(
            child: const Text('Refresh'),
            onPressed: () {
              NewsProvider(apiService: ApiService());
            },
          ),*/
          // const SizedBox(height: 10,),
          Consumer<NewsProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.state == ResultState.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.result.articles.length,
                  itemBuilder: (context, index) {
                    var article = state.result.articles[index];
                    return CardArticle(article: article);
                  },
                );
              } else if (state.state == ResultState.noData) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state.state == ResultState.error) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Center(child: Text(''),);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}



/*
 old use FutureBuilder
*/
/*class ArticleListPage extends StatefulWidget {
  const ArticleListPage({Key? key}) : super(key: key);

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  late Future<ArticleResult> _article;

  @override
  void initState() {
    super.initState();
    _article = ApiService().topHeadlines();
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
            child: const Text('Read more'),
            onPressed: () {
              setState(() {
                _article = ApiService().topHeadlines();
              });
            },
          ),
          const SizedBox(height: 10,),
          FutureBuilder(
            future: _article,
            builder: (context, AsyncSnapshot<ArticleResult> snapshot) {
              var state = snapshot.connectionState;
              if (state != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.articles.length,
                    itemBuilder: (context, index) {
                      var article = snapshot.data?.articles[index];
                      return CardArticle(article: article!);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Text('');
                }
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}*/
