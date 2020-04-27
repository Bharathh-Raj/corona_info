import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/live_stat.dart';
import '../model/world_stat.dart';
import '../bloc/world_stat_bloc/worldstat_bloc.dart' as world;
import '../widgets/cases_chart.dart';
import '../bloc/live_stat_bloc/bloc.dart' as india;

class LiveCountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final indiaStatBloc = BlocProvider.of<india.LiveStatBloc>(context);
    final worldStatBloc = BlocProvider.of<world.WorldstatBloc>(context);

    return BlocBuilder<india.LiveStatBloc, india.LiveStatState>(
        bloc: indiaStatBloc,
        builder: (context, liveStatState) {
          if (liveStatState is india.InitialLiveStatState) {
            print('initialLivestatState');
            indiaStatBloc.add(india.LoadLiveStatEvent(liveStatBloc: indiaStatBloc));
            return Center(child: CircularProgressIndicator());
          } else if (liveStatState is india.SocketExceptionState) {
            print('socketexception');
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
                    indiaStatBloc.add(india.LoadLiveStatEvent(liveStatBloc: indiaStatBloc));
                    // Navigator.pop(context);
                  },
                )
              ],
            ));
          } else if (liveStatState is india.HttpExceptionState) {
            print('httpexception');
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
                    indiaStatBloc.add(india.LoadLiveStatEvent(liveStatBloc: indiaStatBloc));
                    // Navigator.pop(context);
                  },
                )
              ],
            ));
          } else if (liveStatState is india.FetchCompleteState) {
            print('fetchcomplete');
            final statList = liveStatState.statList.last;
            return ListView(
              children: <Widget>[
                Container(
                  // height: MediaQuery.of(context).size.height,
                  child: Stack(children: <Widget>[
                    bgImageContainer(context),
                    indianStat(liveStatState, worldStatBloc,context, statList),
                  ]),
                ),
              ],
            );
          }
          return null;
        });
  }

  Container worldStat(world.WorldstatBloc worldStatBloc,BuildContext context) {
    return Container(
                      child: BlocBuilder<world.WorldstatBloc,
                          world.WorldstatState>(
                    bloc: worldStatBloc,
                    builder: (context, worldStatState) {
                      if (worldStatState is world.InitialWorldStatState) {
                        worldStatBloc
                            .add(world.LoadWorldStatEvent(worldStatBloc));
                        return Center(child: Padding(
                          padding: const EdgeInsets.only(top:100.0),
                          child: CircularProgressIndicator(),
                        ));
                      } else if (worldStatState
                          is world.SocketExceptionState) {
                        return Column(
                          children: <Widget>[
                            Text('Sorry internet might be disconnected'),
                            FlatButton(
                                onPressed: () => worldStatBloc.add(
                                    world.LoadWorldStatEvent(worldStatBloc)),
                                child: Text(
                                  'Try again',
                                  style: TextStyle(color: Colors.red),
                                ))
                          ],
                        );
                      } else if (worldStatState is world.HttpExceptionState) {
                        return Column(
                          children: <Widget>[
                            Text(
                              'Server error!\nPlease,try again later',
                              style: TextStyle(color: Colors.red),
                            ),
                            FlatButton(
                                onPressed: () => worldStatBloc.add(
                                    world.LoadWorldStatEvent(worldStatBloc)),
                                child: Text('Try again'))
                          ],
                        );
                      } else if (worldStatState is world.FetchCompleteState) {
                        WorldStat worldStat=worldStatState.worldStat; 
                        return Column(
                          children: <Widget>[
                            Divider(
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                'Effect of Covid-19 in the World',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            buildRow(
                                context, 'Total Cases:', worldStat.totalCases),
                            buildRow(context, 'Total Recovered:',
                                worldStat.totalRecovered),
                            buildRow(context, 'Total Deaths:',
                                worldStat.totalDeaths),
                            buildRow(context, 'New Cases:',
                                worldStat.newCases),
                            buildRow(context, 'New Deaths:',
                                worldStat.newDeaths),
                            buildLastRow(context,'Last Updated',worldStat.lastUpdate)
                            
                          ],
                        );
                      }
                      return null;
                    },
                  ));
  }

  Column indianStat(india.FetchCompleteState liveStatState,world.WorldstatBloc worldStatBloc,
      BuildContext context, LiveStat statList) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Text('CHART',style: TextStyle(color: Theme.of(context).accentColor,fontWeight: FontWeight.bold,fontSize: 18),),
        ),
        DateVsCasesChart(liveStatState.statList),
        Padding(
          padding: const EdgeInsets.only(top:16.0,bottom:6),
          child: Text('(Date vs # Cases in INDIA)',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor)),
        ),
        Divider(
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            'Effect of Covid-19 in India',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        buildRow(context, 'Total Cases:', statList.totalCases),
        buildRow(context, 'Today\'s Cases:', statList.newCases),
        buildRow(context, 'Active Cases:', statList.activeCases),
        buildRow(context, 'Total Deaths:', statList.totalDeaths),
        buildRow(context, 'Today\'s Deaths:', statList.newDeaths),
        buildRow(context, 'Total Recovered:', statList.totalRecovered),
        // buildRow(context, 'Critical',statList.seriousCritical),
        // buildRow(context, 'Total Cases per Million',statList.totalCasesperMil),
        buildLastRow(
            context, 'Last Updated:', statList.recordDate.substring(0, 16)),
        worldStat(worldStatBloc,context)
      ],
    );
  }

  Container bgImageContainer(BuildContext context) {
    return Container(
        color: Colors.black,
        height: MediaQuery.of(context).orientation == Orientation.landscape
            ? 1000
            : (MediaQuery.of(context).size.height/3)+750,
        child: Opacity(
          opacity: 0.5,
          child: Image.asset('assets/IMG2.jpg', fit: BoxFit.cover),
        ));
  }

  Padding buildRow(BuildContext context, String text, String value) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor)),
          Text(value,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.white))
        ],
      ),
    );
  }

  Row buildLastRow(BuildContext context, String text, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(text,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor)),
        Text(value,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white))
      ],
    );
  }
}
