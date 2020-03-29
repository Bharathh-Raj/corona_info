import 'package:equatable/equatable.dart';

import 'package:corona_app/model/article.dart';

abstract class ArticleState extends Equatable{}

class InitialArticleState extends ArticleState{
  @override
  List<Object> get props => null;
}

class FetchCompleteState extends ArticleState{

  final List<Article> articleList;

  FetchCompleteState(this.articleList);
  
  @override
  List<Object> get props => [articleList];

}

class SocketExceptionState extends ArticleState{
  @override
  List<Object> get props => null;
}

class HttpExceptionState extends ArticleState{
  @override
  List<Object> get props => null;
}