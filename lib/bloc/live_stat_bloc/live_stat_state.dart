import 'package:equatable/equatable.dart';

import 'package:corona_app/model/live_stat.dart';

abstract class LiveStatState extends Equatable{}

class InitialLiveStatState extends LiveStatState{
  @override
  List<Object> get props => null;
}

class FetchCompleteState extends LiveStatState{

  final List<LiveStat> statList;

  FetchCompleteState(this.statList);
  
  @override
  List<Object> get props => [statList];

}

class SocketExceptionState extends LiveStatState{
  @override
  List<Object> get props => null;
}

class HttpExceptionState extends LiveStatState{
  @override
  List<Object> get props => null;
}

