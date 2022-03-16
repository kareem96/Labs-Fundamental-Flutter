
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_api/data/model/article.dart';

class ApiService{
  static final String _baseUrl = 'https://newsapi.org/v2/';
  static final String _apiKey = '7fd3482b6c1f45f2a26c3b3c49ad1434';
  static final String _category = 'business';
  static final String _country = 'id';
  
  
  Future<ArticleResult> topHeadlines() async{
    final response = await http.get(Uri.parse(_baseUrl + "top-headlines?country=$_country&category=$_category&apiKey=$_apiKey"));
    if(response.statusCode == 200){
      return ArticleResult.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load top headlines');
    }
  }
}