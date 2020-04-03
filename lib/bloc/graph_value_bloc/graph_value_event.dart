part of 'graph_value_bloc.dart';

abstract class GraphValueEvent extends Equatable{}

class LoadGraphValueEvent extends GraphValueEvent{
  final List<LiveStat> stat; 

  LoadGraphValueEvent({this.stat});
  @override
  List<Object> get props => [stat];

}