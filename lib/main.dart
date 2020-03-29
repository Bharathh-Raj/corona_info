import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/live_stat_bloc/live_stat_bloc.dart';
import 'bloc/news_article_bloc/bloc.dart';
import 'bloc/page_navigation_bloc/bloc.dart';
import 'pages/article_page.dart';
import 'pages/live_count_page.dart';

void main() {
  runApp(
    MaterialApp(
        title: 'Corona Info',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<NewsArticleBloc>(
              create:(ctx)=>NewsArticleBloc(),
            ),
            BlocProvider<PageNavigationBloc>(
              create:(ctx)=>PageNavigationBloc(),
            ),
            BlocProvider<LiveStatBloc>(
              create:(ctx)=>LiveStatBloc(),
            )
          ],
          child: MyApp())),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final navigationBloc=BlocProvider.of<PageNavigationBloc>(context);
    return  Scaffold(
            appBar: AppBar(
              title: Text('COVID-19 Info'),
            ),
            bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                buttonBackgroundColor: Theme.of(context).accentColor,
                height: 50,
                color: Theme.of(context).accentColor,
                key: _bottomNavigationKey,
                items: <Widget>[
                  Icon(
                    Icons.assessment,
                      size: 30, color: Theme.of(context).scaffoldBackgroundColor),
                  Icon(
                    Icons.list,
                    size: 30,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ],
                onTap: (index) {
                  if(index==0)
                    navigationBloc.add(LiveCountPageEvent());
                  else if(index==1)
                    navigationBloc.add(ArticlePageEvent());
                },
              ),
            body: BlocBuilder<PageNavigationBloc,PageNavigationState>(
              bloc: navigationBloc,
                builder:(ctx,pageNavigationState){
                  if(pageNavigationState is ArticlePageState)
                    return ArticlePage();
                  else if(pageNavigationState is LiveCountPageState)
                    return LiveCountPage();
                  return null;
                }
            )
    );
  }
}