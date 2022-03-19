import 'package:flutter/material.dart';
import 'package:news_app_api/common/styles.dart';
import 'package:news_app_api/data/model/article.dart';
import 'package:news_app_api/provider/database_provider.dart';
import 'package:provider/provider.dart';

import '../ui/article_detail_page.dart';

class CardArticle extends StatelessWidget {
  final Article article;

  const CardArticle({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(article.url),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                leading: Hero(
                  tag: article.urlToImage!,
                  child: Image.network(
                    article.urlToImage!,
                    width: 100,
                  ),
                ),
                trailing: isBookmarked
                    ? IconButton(
                        icon: Icon(Icons.bookmark),
                        color: Theme.of(context).accentColor,
                        onPressed: () => provider.removeBookmark(article.url),
                      )
                    : IconButton(
                        icon: Icon(Icons.bookmark_border),
                        color: Theme.of(context).accentColor,
                        onPressed: () => provider.addBookmark(article),
                      ),
                title: Text(article.title),
                onTap: () => Navigator.pushNamed(
                    context, ArticleDetailPage.routeName,
                    arguments: article),
              ),
            );
          },
        );
      },
    );
  }
}
