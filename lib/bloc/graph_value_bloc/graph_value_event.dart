part of 'graph_value_bloc.dart';

abstract class GraphValueEvent extends Equatable{}

class LoadGraphValueEvent extends GraphValueEvent{
  final List<LiveStat> indiaStat; 

  LoadGraphValueEvent({this.indiaStat});
  @override
  List<Object> get props => [indiaStat];

}