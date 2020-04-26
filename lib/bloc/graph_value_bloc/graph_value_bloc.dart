import 'package:corona_app/model/live_stat.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'graph_value_state.dart';
part 'graph_value_event.dart';

class GraphValueBloc extends Bloc<GraphValueEvent, GraphValueState> {
  @override
  GraphValueState get initialState => InitialGraphValueState();

  @override
  Stream<GraphValueState> mapEventToState(GraphValueEvent event) async*{
    if (event is LoadGraphValueEvent) {
      mapLoadEventToState(event);
    }
  }

  Stream<LoadedGraphValueState> mapLoadEventToState(LoadGraphValueEvent event) async*{
    List<String> dateList;
    List<String> numCasesList;
    
    event.indiaStat.forEach((val) {
      dateList.add(val.recordDate.substring(8, 10) +
          "\n-\n" +
          val.recordDate.substring(5, 7));                      //Gives In the format 21-03 or 31-05
      numCasesList.add(val.totalCases);
    });
    
    double baseY=getBaseY(numCasesList.last);
    
    List<String> listOfXaxis= dateList;
    List<String> listOfYaxis = List.generate(8, (ind) => (baseY * double.parse(ind.toString()).round()).toString());
    List<FlSpot> listOfSpot=List.generate(numCasesList.length, (ind)=>FlSpot(ind.toDouble(),double.parse(numCasesList[ind])/baseY));
    double maxXcoordinate=dateList.length.toDouble();
    double maxYcoordinate=8.0;
    
    yield LoadedGraphValueState(listOfXaxis: listOfXaxis,listOfYaxis: listOfYaxis,listOfSpot: listOfSpot,maxXcoordinates: maxXcoordinate,maxYcoordinates: maxYcoordinate);
  }

  double getBaseY(String largestNumCases) {
    int secondDigit = int.parse(largestNumCases.substring(1, 2));
    StringBuffer roundedLargestY;

    //round of the largestNumCases eg:1475=>1500 or 11987=>12000
    if (secondDigit >= 5) {
      roundedLargestY = new StringBuffer();
      for (int i = 0; i < largestNumCases.length; i++) {
        if (i == 0)
          roundedLargestY.write(
              (int.parse(largestNumCases.substring(0, 1)) + 1).toString());
        else {
          roundedLargestY.write('0');
        }
      }
    } else if (secondDigit < 5) {
      roundedLargestY = new StringBuffer();
      for (int i = 0; i < largestNumCases.length; i++) {
        if (i == 0) {
          roundedLargestY.write(largestNumCases.substring(0, 1));
        } else if (i == 1) {
          roundedLargestY.write('5');
        } else {
          roundedLargestY.write('0');
        }
      }
    } 
    return double.parse(roundedLargestY.toString())/8;
  }
}
