import 'package:flutter/cupertino.dart';
import 'package:news_app_api/data/api/api-service.dart';
import 'package:news_app_api/data/model/article.dart';




/*
*
*/
enum ResultState { loading, noData, hasData, error }

class NewsProvider extends ChangeNotifier {
  final ApiService apiService;

  NewsProvider({required this.apiService}) {
    _fetchAllArticle();
  }

  late ArticleResult _articleResult;
  ArticleResult get result => _articleResult;

  String _message = '';
  String get message => _message;

  late ResultState _state;
  ResultState get state => _state;


  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final article = await apiService.topHeadlines();
      if(article.articles.isEmpty){
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      }else{
        _state= ResultState.hasData;
        notifyListeners();
        return _articleResult = article;
      }
    }catch(e){
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }


}