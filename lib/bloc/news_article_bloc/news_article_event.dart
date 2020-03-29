import 'package:equatable/equatable.dart';

import 'package:corona_app/bloc/news_article_bloc/bloc.dart';

abstract class ArticleEvent extends Equatable{}

class InitialArticleEvent extends ArticleEvent{
  @override
  List<Object> get props => null;
}

class LoadArticleEvent extends ArticleEvent{
  final NewsArticleBloc articleBloc;

  LoadArticleEvent(this.articleBloc);
  @override
  List<Object> get props => null;
}

class SocketExceptionEvent extends ArticleEvent{
  @override
  List<Object> get props => null;
}

class HttpExceptionEvent extends ArticleEvent{
  @override
  List<Object> get props => null;
}
