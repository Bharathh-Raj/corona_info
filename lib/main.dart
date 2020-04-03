import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/graph_value_bloc/graph_value_bloc.dart';
import 'bloc/world_stat_bloc/worldstat_bloc.dart';
import 'bloc/live_stat_bloc/live_stat_bloc.dart';
import 'bloc/news_article_bloc/bloc.dart';
import 'bloc/page_navigation_bloc/bloc.dart';
import 'bloc/state_stat_bloc/statestatbloc_bloc.dart';
import 'pages/article_page.dart';
import 'pages/state_stat_page.dart';
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
            ),
            BlocProvider(
              create: (ctx)=>StateStatBloc(),
            ),
            BlocProvider(
              create:(ctx)=>WorldstatBloc(),
            ),
            BlocProvider(
              create: (ctx)=>GraphValueBloc(),
            )
          ],
          child: MyApp())),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey _bottomNavigationKey = GlobalKey();

  _launchURL() async {
  const url = 'https://www.instagram.com/bharathh_raj/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
    final navigationBloc=BlocProvider.of<PageNavigationBloc>(context);
    return  Scaffold(
            appBar: AppBar(
              title: Text('COVID-19 Info'),
              actions: <Widget>[
                IconButton(icon: FaIcon(FontAwesomeIcons.instagram), onPressed: _launchURL)
              ],
            ),
            bottomNavigationBar: CurvedNavigationBar(
              animationDuration: Duration(milliseconds: 400),
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
                    Icons.location_on,
                    size:30,
                    color:Theme.of(context).scaffoldBackgroundColor,
                  ),
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
                    navigationBloc.add(StateStatPageEvent());
                  else if(index==2)
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
                  else if(pageNavigationState is StateStatPageState)
                    return StateStatPage();
                  return null;
                }
            )
    );
  }
}
