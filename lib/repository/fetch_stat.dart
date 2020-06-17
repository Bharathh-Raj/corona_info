import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../bloc/live_stat_bloc/bloc.dart';
import '../model/live_stat.dart';


Future<List<LiveStat>> fetchStat(LiveStatBloc statBloc) async{
  const String url = "https://coronavirus-monitor.p.rapidapi.com/coronavirus/cases_by_particular_country.php?country=india";
  final Map<String, String> headers={"x-rapidapi-host":"coronavirus-monitor.p.rapidapi.com","x-rapidapi-key":"91cf81e77fmsh8f290777b985434p1d029bjsn4bbca0dc1c7d"};
  final liveStatList=new List<LiveStat>();
  http.Response response;
  try{
    print('try http.get');
    response=await http.get(url,headers:headers);
    print('crossed try http.get');
  }on SocketException{
    print('socketexception');
    statBloc.add(SocketExceptionEvent());
  }on HttpException{
    print('httpexception');
    statBloc.add(HttpExceptionEvent());
  }catch(exception){
    print(exception);
  }
  if(response.statusCode==200){
    final responseJson=json.decode(response.body)['stat_by_country'];
    for(var i in responseJson){
      liveStatList.add(LiveStat.fromJson(i));
    }
    return getDateList(liveStatList);
  }else{
    return null;
  }
}

List<LiveStat> getDateList(List<LiveStat> livestat){
  // List<LiveStat> reversedStat=new List.from(livestat.reversed);
  List<LiveStat> reversedStat=livestat;
  List<int> indOfStatPerDay=[];
  indOfStatPerDay.add(0);
  for(int i=0;i<reversedStat.length-1;i++){
    if(reversedStat[i].recordDate.substring(0,10)!=reversedStat[i+1].recordDate.substring(0,10))
      indOfStatPerDay.add(i+1);
  }
  List<LiveStat> casesPerDay=new List<LiveStat>();
  indOfStatPerDay.forEach((val)=>casesPerDay.add(reversedStat[val]));
  reversedStat=new List.from(casesPerDay.reversed);
  return reversedStat;
}
