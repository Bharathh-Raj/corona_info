part of 'worldstat_bloc.dart';

abstract class WorldstatEvent extends Equatable {
  const WorldstatEvent();
  @override
  List<Object> get props => null;
}

class InitialWorldStatEvent extends WorldstatEvent{}

class LoadWorldStatEvent extends WorldstatEvent{
  final WorldstatBloc worldStatBloc;
  LoadWorldStatEvent(this.worldStatBloc);
}

class SocketExceptionEvent extends WorldstatEvent{}

class HttpExceptionEvent extends WorldstatEvent{}