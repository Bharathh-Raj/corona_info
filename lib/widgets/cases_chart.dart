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

  @override
  Widget build(BuildContext context) {
    dateList = new List<String>();
    casesList = new List<String>();
    flSpotList=new List<FlSpot>();

    widget.statList.forEach((val) {
      dateList.add(val.recordDate.substring(0, 10));
      casesList.add(val.totalCases);
    });
    print(widget.statList.length);
    print(dateList);

    for(int i=0;i<dateList.length;i++){
      flSpotList.add(FlSpot(double.parse(i.toString()),double.parse(casesList[i].toString())/500));
    }
    return Stack(
      children: <Widget>[
        AspectRatio(
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
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            return dateList[value.toInt()].substring(8,10);
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '500';
              case 2:
                return '1000';
              case 3:
                return '1500';
              case 4:
                return '2000';
              case 5:
                return '2500';
              case 6:
                return '3000';
              case 7:
                return '3500';
              case 8:
                return '4000';
            }
            return '';
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
