import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/cases_chart.dart';
import '../bloc/live_stat_bloc/bloc.dart';

class LiveCountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final liveStatBloc = BlocProvider.of<LiveStatBloc>(context);

    return BlocBuilder<LiveStatBloc, LiveStatState>(
        bloc: liveStatBloc,
        builder: (context, liveStatState) {
          if (liveStatState is InitialLiveStatState) {
            liveStatBloc.add(LoadLiveStatEvent(liveStatBloc));
            return Center(child: CircularProgressIndicator());
          } else if (liveStatState is SocketExceptionState) {
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
                    liveStatBloc.add(LoadLiveStatEvent(liveStatBloc));
                  },
                )
              ],
            ));
          } else if (liveStatState is HttpExceptionState) {
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
                    liveStatBloc.add(LoadLiveStatEvent(liveStatBloc));
                    Navigator.pop(context);
                  },
                )
              ],
            ));
          } else if (liveStatState is FetchCompleteState) {
            final statList = liveStatState.statList.last;
            return ListView(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(children: <Widget>[
                    bgImageContainer(context),
                    Column(
                      children: <Widget>[
                        DateVsCasesChart(liveStatState.statList),
                        Text('(Date vs # Cases)',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor)),
                        Divider(
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            'Effect of Covid-19 in India',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        buildRow(context, 'Total Cases:', statList.totalCases),
                        buildRow(context, 'Today\'s Cases:', statList.newCases),
                        buildRow(
                            context, 'Active Cases:', statList.activeCases),
                        buildRow(
                            context, 'Total Deaths:', statList.totalDeaths),
                        buildRow(
                            context, 'Today\'s Deaths:', statList.newDeaths),
                        buildRow(context, 'Total Recovered:',
                            statList.totalRecovered),
                        // buildRow(context, 'Critical',statList.seriousCritical),
                        // buildRow(context, 'Total Cases per Million',statList.totalCasesperMil),
                        buildLastRow(context, 'Last Updated:',
                            statList.recordDate.substring(0, 16)),
                      ],
                    ),
                  ]),
                ),
              ],
            );
          }
          return null;
        });
  }

  Container bgImageContainer(BuildContext context) {
    return Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
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
