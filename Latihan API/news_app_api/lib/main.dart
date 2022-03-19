import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_api/common/navigation.dart';
import 'package:news_app_api/common/styles.dart';
import 'package:news_app_api/data/api/api-service.dart';
import 'package:news_app_api/data/db/database_helper.dart';
import 'package:news_app_api/data/model/article.dart';
import 'package:news_app_api/data/preferences/preferences_helper.dart';
import 'package:news_app_api/provider/database_provider.dart';
import 'package:news_app_api/provider/news_provider.dart';
import 'package:news_app_api/provider/preferences_provider.dart';
import 'package:news_app_api/ui/article_detail_page.dart';
import 'package:news_app_api/ui/article_webview.dart';
import 'package:news_app_api/ui/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
                  preferencesHelper: PreferencesHelper(
                      sharedPreferences: SharedPreferences.getInstance()),
                ))
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'News App',
            navigatorKey: navigatorKey,
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                  data: CupertinoThemeData(
                      brightness: provider.isDarkTheme
                          ? Brightness.dark
                          : Brightness.light),
                  child: Material(
                    child: child,
                  ));
            },
            initialRoute: HomePage.routeName,
            routes: {
              HomePage.routeName: (context) => HomePage(),
              ArticleDetailPage.routeName: (context) => ArticleDetailPage(
                    article:
                        ModalRoute.of(context)?.settings.arguments as Article,
                  ),
              ArticleWebView.routeName: (context) => ArticleWebView(
                    url: ModalRoute.of(context)?.settings.arguments as String,
                  ),
            },
          );
        },
      ),
    );
  }
}
