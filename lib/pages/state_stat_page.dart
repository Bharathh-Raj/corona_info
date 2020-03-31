import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/state_stat.dart';
import '../bloc/state_stat_bloc/statestatbloc_bloc.dart';

class StateStatPage extends StatelessWidget {
  BuildContext ctx;
  @override
  Widget build(BuildContext context) {
    ctx = context;
    return buildContainer();
  }

  Widget buildContainer() {
    final stateStatBloc = BlocProvider.of<StateStatBloc>(ctx);
    return BlocBuilder(
        bloc: stateStatBloc,
        builder: (ctx, statestatblocState) {
          if (statestatblocState is InitialStateStatState) {
            stateStatBloc.add(LoadStateStatEvent(stateStatBloc));
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (statestatblocState is SocketExceptionState) {
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
                    stateStatBloc.add(LoadStateStatEvent(stateStatBloc));
                  },
                )
              ],
            ));
          } else if (statestatblocState is HttpExceptionState) {
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
                    stateStatBloc.add(LoadStateStatEvent(stateStatBloc));
                    // Navigator.pop(ctx);
                  },
                )
              ],
            ));
          }
          else if (statestatblocState is FetchCompleteState) {
            return ListView.builder(
                itemCount: statestatblocState.statList.length,
                itemBuilder: (ctx, ind) {
                  StateStat stateStat=statestatblocState.statList[ind];
                  return Padding(
                    padding: const EdgeInsets.only(bottom:4.0),
                    child: Card(
                      elevation: 2.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:4.0),
                            child: Text(stateStat.place,style: TextStyle(
                              color: Theme.of(ctx).accentColor,
                              fontSize: 18,
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Cases:${stateStat.confirmed}'),
                                Text('Cured:${stateStat.cured}'),
                                Text('Deaths:${stateStat.deaths}'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
          else return null;
        });
  }
}
