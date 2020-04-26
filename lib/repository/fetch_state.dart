// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'dart:io';

// import '../bloc/state_stat_bloc/statestatbloc_bloc.dart';
// import '../model/state_stat.dart';

// Future<List<StateStat>> fetchStateStat(StateStatBloc stateStatBloc) async{
//   const String url='https://covid-india-api.herokuapp.com/api';
//   http.Response response;
//   try{
//     response=await http.get(url);
//   }on SocketException{
//     stateStatBloc.add(SocketExceptionEvent());
//   }on HttpException{
//     stateStatBloc.add(HttpExceptionEvent());
//   }catch(exception){
//     print(exception);
//   }
//   if(response.statusCode==200){
//     final List<StateStat> stateStatList=new List<StateStat>();
//     final responseJson=json.decode(response.body)['data']['state_data'];
//     for(var i in responseJson){
//       stateStatList.add(StateStat.fromJson(i));
//     }
//     return stateStatList;
//   }
//   else{
//     return null;
//   }
// }