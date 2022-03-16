import 'package:flutter/material.dart';
import 'package:news_app_api/data/model/article.dart';
import 'package:news_app_api/ui/article_webview.dart';

class ArticleDetailPage extends StatefulWidget {
  static const routeName = '/detail_page';
  final Article article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News app'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.article.urlToImage == null
                ? Container(
                    height: 200,
                    child: Icon(Icons.error),
                  )
                : Hero(
                    tag: widget.article,
                    child: Image.network(widget.article.urlToImage!)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.article.description ?? '',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    widget.article.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    'Date ${widget.article.publishedAt}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Author ${widget.article.author}'),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    widget.article.content ?? '',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ArticleWebView.routeName,
                            arguments: widget.article.url);
                      },
                      child: const Text('Read more'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
