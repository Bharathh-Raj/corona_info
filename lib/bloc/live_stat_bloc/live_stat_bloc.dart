import 'package:bloc/bloc.dart';

import 'package:corona_app/bloc/live_stat_bloc/live_stat_state.dart';
import 'package:corona_app/model/live_stat.dart';
import 'package:corona_app/repository/fetch_stat.dart';
import 'bloc.dart';



class LiveStatBloc extends Bloc <LiveStatEvent, LiveStatState> {
  @override
 LiveStatState get initialState => InitialLiveStatState();

  @override
  Stream <LiveStatState> mapEventToState(
   LiveStatEvent event,
  ) async* {
    if(event is InitialLiveStatEvent){
      yield InitialLiveStatState();
    }
    else if(event is LoadLiveStatEvent){
      List<LiveStat> statList = await fetchStat(event.liveStatBloc);
      yield FetchCompleteState(statList);
    }
    else if(event is SocketExceptionEvent){
      yield SocketExceptionState();
    }
    else if(event is HttpExceptionEvent){
      yield HttpExceptionState();
    }
  }
}