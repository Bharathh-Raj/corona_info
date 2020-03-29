import 'package:bloc/bloc.dart';

import 'package:corona_app/model/article.dart';
import 'package:corona_app/repository/fetch_article.dart';
import 'bloc.dart';

class NewsArticleBloc extends Bloc <ArticleEvent, ArticleState> {
  @override
 ArticleState get initialState => InitialArticleState();

  @override
  Stream <ArticleState> mapEventToState(
   ArticleEvent event,
  ) async* {
    if(event is InitialArticleEvent){
      yield InitialArticleState();
    }
    else if(event is LoadArticleEvent){
      List<Article> articleList = await fetchArticle(event.articleBloc);
      yield FetchCompleteState(articleList);
    }
    else if(event is SocketExceptionEvent){
      yield SocketExceptionState();
    }
    else if(event is HttpExceptionEvent){
      yield HttpExceptionState();
    }
  }
}