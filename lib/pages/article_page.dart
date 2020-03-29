import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart' as url;

import '../bloc/news_article_bloc/bloc.dart';

class ArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final articleBloc = BlocProvider.of<NewsArticleBloc>(context);
    return BlocBuilder<NewsArticleBloc, ArticleState>(
        bloc: articleBloc,
        builder: (context, articleState) {
          if (articleState is InitialArticleState) {
            articleBloc.add(LoadArticleEvent(articleBloc));
            return Center(child: CircularProgressIndicator());
          } else if (articleState is SocketExceptionState) {
            return Center(
                child: AlertDialog(
              content: Text('Internet is not available...'),
              title: Text(
                'Failure',
                style: TextStyle(color: Colors.red),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Try again'),
                  onPressed: () {
                    // Navigator.pop(context);
                    articleBloc.add(LoadArticleEvent(articleBloc));
                  },
                )
              ],
            ));
          } else if (articleState is HttpExceptionState) {
            return Center(
                child: AlertDialog(
              content: Text('Server error!'),
              title: Text(
                'Failure',
                style: TextStyle(color: Colors.red),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Try again'),
                  onPressed: () {
                    articleBloc.add(LoadArticleEvent(articleBloc));
                    Navigator.pop(context);
                  },
                )
              ],
            ));
          } else if (articleState is FetchCompleteState) {
            return ListView.builder(
                itemCount: articleState.articleList.length,
                itemBuilder: (ctx, index) {
                  var article = articleState.articleList[index];
                  return ExpansionTile(
                    title: Text(article.title),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          article.source,
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        Text(article.dateTime,
                            style: TextStyle(color: Colors.grey, fontSize: 10))
                      ],
                    ),
                    leading: Container(
                        width: 100,
                        height: 100,
                        child: article.imageUrl == null
                            ? Icon(Icons.image)
                            : Image.network(
                                article.imageUrl,
                                fit: BoxFit.fill,
                              )),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(article.description + "...",
                                    style: TextStyle(fontSize: 13))),
                            IconButton(
                              icon: Icon(Icons.open_in_new),
                              onPressed: () async {
                                await url.launch(article.url);
                              },
                              color: Theme.of(context).accentColor,
                            )
                          ],
                        ),
                      )
                    ],
                  );
                });
          } else
            return null;
        });
  }
}
