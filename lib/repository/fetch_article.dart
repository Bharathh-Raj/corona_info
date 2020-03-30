import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../bloc/news_article_bloc/bloc.dart';
import '../model/article.dart';

Future<List<Article>> fetchArticle(NewsArticleBloc articleBloc) async{
  const String url = 'http://newsapi.org/v2/everything?q=india+corona&sortBy=publishedAt&pageSize=30&apiKey=96a90e61b6dc43d7937788d095709194';
  final articleList=new List<Article>();
  http.Response response;
  try{
    response=await http.get(url);
  }on SocketException{
    articleBloc.add(SocketExceptionEvent());
  }on HttpException{
    articleBloc.add(HttpExceptionEvent());
  }catch(exception){
    print(exception);
  }
  if(response.statusCode==200){
    final responseJson=json.decode(response.body);
    for(var i in responseJson['articles']){
      articleList.add(Article.fromJson(i));
    }
    return articleList;
  }else{
  }
}