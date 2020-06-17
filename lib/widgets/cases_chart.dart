import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/live_stat.dart';

class DateVsCasesChart extends StatefulWidget {
  final List<LiveStat> statList;
  DateVsCasesChart(this.statList);

  @override
  _DateVsCasesChartState createState() => _DateVsCasesChartState();
}

class _DateVsCasesChartState extends State<DateVsCasesChart> {
  List<Color> gradientColors = [
    const Color(0xff02d39a),
    Colors.green,
  ];

  List<String> casesList;
  List<String> dateList;
  List<FlSpot> flSpotList;

  double dividerToGetTwentyEntries;

  int baseYData;

  int baseYaxisData(String lastCaseNumber){
    double secondDigit=double.parse(lastCaseNumber.substring(1,2));
    StringBuffer baseY;
    if(secondDigit>=5){
      baseY=new StringBuffer();
      for(int i=0;i<lastCaseNumber.length;i++){
        if(i==0)
          baseY.write((int.parse(lastCaseNumber.substring(0,1))+1).toString());
        else{
          baseY.write('0');
        }
      }
      return int.parse(baseY.toString());
    }
    else if(secondDigit<5){
      baseY=new StringBuffer();
      for(int i=0;i<lastCaseNumber.length;i++){
        if(i==0){
          baseY.write(lastCaseNumber.substring(0,1));
        }
        else if(i==1){
          baseY.write('5');
        }
        else{
          baseY.write('0');
        }
      }
      return int.parse(baseY.toString());
    }
    else return null;
  }

  @override
  void initState() {
    dateList = new List<String>();
    casesList = new List<String>();
    flSpotList=new List<FlSpot>();

    // dividerToGetTwentyEntries=dateList.length%20;

    widget.statList.forEach((val) {
      dateList.add(val.recordDate.substring(0, 10));
      casesList.add(val.totalCases);
    });

    baseYData=(baseYaxisData(casesList.last))~/8;

    for(int i=0;i<dateList.length;i++){
      flSpotList.add(FlSpot(double.parse(i.toString()),double.parse(casesList[i].toString())/baseYData));
    }

    for(int i=0;i<casesList.length;i++){
      print('✅✅'+casesList[i]+"=="+dateList[i]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // dateList = new List<String>();
    // casesList = new List<String>();
    // flSpotList=new List<FlSpot>();

    // widget.statList.forEach((val) {
    //   dateList.add(val.recordDate.substring(0, 10));
    //   casesList.add(val.totalCases);
    // });

    // casesList=casesList.reversed.toList();
    // dateList=dateList.reversed.toList();

    // baseYData=(baseYaxisData(casesList.last))~/8;

    // for(int i=0;i<dateList.length;i++){
    //   flSpotList.add(FlSpot(double.parse(i.toString()),double.parse(casesList[i].toString())/baseYData));
    // }

    // for(int i=0;i<casesList.length;i++){
    //   print('✅✅'+casesList[i]+"=="+dateList[i]);
    // }
    dividerToGetTwentyEntries=dateList.length/20;
    
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).orientation==Orientation.landscape?MediaQuery.of(context).size.height:MediaQuery.of(context).size.height/3,
          child: AspectRatio(
            aspectRatio: 1.5,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color:Colors.transparent
                  ),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 18.0, left: 12.0, top: 24, bottom: 0),
                child: LineChart(
                  mainData(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(getTooltipItems:(touchedSpots){if (touchedSpots == null) {
    return null;
  }

  return touchedSpots.map((LineBarSpot touchedSpot) {
    if (touchedSpot == null) {
      return null;
    }
    final TextStyle textStyle = TextStyle(
      color: touchedSpot.bar.colors[0],
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return LineTooltipItem("Date:"+dateList[touchedSpot.spotIndex].toString()+"\nCases:"+casesList[touchedSpot.spotIndex].toString(), textStyle);
  }).toList();} )),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(                          // X AXIS DATA
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(
              color: Colors.white, fontSize: 8),
          getTitles: (value) {
            String presentValue=dateList[value.toInt()];
            if(value%dividerToGetTwentyEntries<1){
              print(value);
              return presentValue.substring(8,10)+"\n-"+'\n'+presentValue.substring(5,7);
            }
            else 
              return '';
          },
          margin: 6,
        ),
        leftTitles: SideTitles(                             //Y AXIS DATA
          showTitles: true,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 9,
          ),
          getTitles: (value) {
            // if(value==8){
            //   return baseYaxisData(casesList.last).toString();
            // }
            return (baseYData*(value.toInt())).toString();
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false, border: Border.all(color: Colors.green, width: 1)),
      minX: 0,
      maxX: double.parse(dateList.length.toString())-1,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: flSpotList,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
