import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:corona_app/model/state_stat.dart';
import 'package:corona_app/repository/fetch_state.dart';

part 'statestatbloc_event.dart';
part 'statestatbloc_state.dart';

class StateStatBloc extends Bloc<StatestatblocEvent, StatestatblocState> {
  @override
  StatestatblocState get initialState => InitialStateStatState();

  @override
  Stream<StatestatblocState> mapEventToState(
    StatestatblocEvent event,
  ) async* {
    if(event is InitialStateStatEvent)
      yield InitialStateStatState();
    else if(event is LoadStateStatEvent){
      List<StateStat> stateStatList = await fetchStateStat(event.liveStatBloc);
      yield FetchCompleteState(stateStatList);
    }
    else if(event is SocketExceptionEvent){
      yield SocketExceptionState();
    }
    else if(event is HttpExceptionEvent){
      yield HttpExceptionState();
    }
  }
}
