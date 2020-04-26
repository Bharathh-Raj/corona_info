part of 'graph_value_bloc.dart';

abstract class GraphValueState extends Equatable {
  @override
  List<Object> get props => null;
}

class InitialGraphValueState extends GraphValueState {}

class LoadedGraphValueState extends GraphValueState {
  final List<String> listOfXaxis;
  final List<String> listOfYaxis;
  final List<FlSpot> listOfSpot;
  final double maxXcoordinates;
  final double maxYcoordinates;

  LoadedGraphValueState({this.listOfXaxis, this.listOfYaxis, this.listOfSpot ,this.maxXcoordinates ,this.maxYcoordinates});

  @override
  List<Object> get props => [listOfXaxis, listOfYaxis, listOfSpot ,maxXcoordinates ,maxYcoordinates];
}
