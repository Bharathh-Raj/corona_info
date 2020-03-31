import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:corona_app/model/world_stat.dart';
import 'package:corona_app/repository/fetch_world.dart';

part 'worldstat_event.dart';
part 'worldstat_state.dart';

class WorldstatBloc extends Bloc<WorldstatEvent, WorldstatState> {
  @override
  WorldstatState get initialState => InitialWorldStatState();

  @override
  Stream<WorldstatState> mapEventToState(
    WorldstatEvent event,
  ) async* {
    if(event is InitialWorldStatEvent)
      yield InitialWorldStatState();
    else if(event is LoadWorldStatEvent){
      final WorldStat worldStat=await fetchWorld(event.worldStatBloc);
      yield FetchCompleteState(worldStat);
    }
    else if(event is SocketExceptionEvent)
      yield SocketExceptionState();
    else if(event is HttpExceptionEvent)
      yield(HttpExceptionState());
  }
}
