import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_api/widgets/card_article.dart';
import 'package:news_app_api/widgets/platform_widget.dart';

import '../data/api/api-service.dart';
import '../data/model/article.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({Key? key}) : super(key: key);

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  late Future<ArticleResult> _article;

  @override
  void initState() {
    // TODO: implement initState
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
}
