import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../bloc/world_stat_bloc/worldstat_bloc.dart';
import '../model/world_stat.dart';

Future<WorldStat> fetchWorld(WorldstatBloc worldStatBloc) async{
  const String url='https://coronavirus-monitor.p.rapidapi.com/coronavirus/world_total_stat.php';
  final Map<String, String> headers={"x-rapidapi-host":"coronavirus-monitor.p.rapidapi.com","x-rapidapi-key":"91cf81e77fmsh8f290777b985434p1d029bjsn4bbca0dc1c7d"};
  http.Response response;
  try{
    response=await http.get(url,headers: headers);
  }on SocketException{
    worldStatBloc.add(SocketExceptionEvent());
  }on HttpException{
    worldStatBloc.add(HttpExceptionEvent());
  }catch(exception){
    print(exception);
  }
  if(response.statusCode==200){
    final responseJson=json.decode(response.body);
    WorldStat worldStat=WorldStat.fromJson(responseJson);
    return worldStat;
  }
  else{
    print('failed.....................................................');
    return null;
  }
}