part of 'worldstat_bloc.dart';

abstract class WorldstatState extends Equatable {
  const WorldstatState();
  @override
  List<Object> get props => null;
}

class InitialWorldStatState extends WorldstatState{}

class FetchCompleteState extends WorldstatState{
  final WorldStat worldStat;
  FetchCompleteState(this.worldStat);
}

class SocketExceptionState extends WorldstatState{}

class HttpExceptionState extends WorldstatState{}
