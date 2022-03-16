


import 'package:flutter/material.dart';
import 'package:news_app_api/common/styles.dart';
import 'package:news_app_api/data/model/article.dart';

import '../ui/article_detail_page.dart';

class CardArticle extends StatelessWidget {
  final Article article;
  const CardArticle({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        leading: Hero(
          tag: article.urlToImage!,
          child: Image.network(
            article.urlToImage!,
            width: 100,
          ),
        ),
        title: Text(article.title),
        onTap: () => Navigator.pushNamed(context, ArticleDetailPage.routeName, arguments: article),
      ),
    );
  }
}
