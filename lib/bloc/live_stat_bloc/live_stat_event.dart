import 'package:equatable/equatable.dart';

import 'package:corona_app/bloc/graph_value_bloc/graph_value_bloc.dart';
import 'package:corona_app/bloc/live_stat_bloc/bloc.dart';

abstract class LiveStatEvent extends Equatable {}

class InitialLiveStatEvent extends LiveStatEvent {
  @override
  List<Object> get props => null;
}

class LoadLiveStatEvent extends LiveStatEvent {
  final LiveStatBloc liveStatBloc;
  // final GraphValueBloc graphValueBloc;

  LoadLiveStatEvent({
    this.liveStatBloc,
    // this.graphValueBloc,
  });

  @override
  List<Object> get props => null;
}

class SocketExceptionEvent extends LiveStatEvent {
  @override
  List<Object> get props => null;
}

class HttpExceptionEvent extends LiveStatEvent {
  @override
  List<Object> get props => null;
}
