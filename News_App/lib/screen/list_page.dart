import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/screen/detail_page.dart';

import '../styles.dart';
import 'article_webview.dart';
import 'news_list_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(elevation: 0),
        textTheme: myTextTheme,
        colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: primaryColor,
            onPrimary: Colors.black,
            secondary: secondColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: secondColor,
                onPrimary: Colors.white,
                textStyle: TextStyle(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))))),
        // primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: NewsListPage.routeName,
      routes: {
        NewsListPage.routeName: (context) => NewsListPage(),
        ArticleDetailPage.routeName: (context) => ArticleDetailPage(
          article: ModalRoute.of(context)?.settings.arguments as Article,
        ),
        ArticleWebView.routeName: (context) => ArticleWebView(
          url: ModalRoute.of(context)?.settings.arguments as String,
        )
      },
    );
  }
}