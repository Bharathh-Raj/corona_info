import 'package:equatable/equatable.dart';

class LiveStat extends Equatable {
  final String totalCases;
  final String newCases;
  final String activeCases;
  final String totalDeaths;
  final String newDeaths;
  final String totalRecovered;
  final String seriousCritical;
  final String totalCasesperMil;
  final String recordDate;

  LiveStat(
      {this.totalCases,
      this.newCases,
      this.activeCases,
      this.totalDeaths,
      this.newDeaths,
      this.totalRecovered,
      this.seriousCritical,
      this.totalCasesperMil,
      this.recordDate});

      
  factory LiveStat.fromJson(Map<String, dynamic> json) {
    String onlyNumeric=json['total_cases'].toString().replaceAll(',', '');
    
    return LiveStat(
        totalCases: onlyNumeric==''?'0':onlyNumeric,
        newCases: json['new_cases']==''?'0':json['new_cases'],
        activeCases: json['active_cases']==''?'0':json['active_cases'],
        totalDeaths: json['total_deaths']==''?'0':json['total_deaths'],
        newDeaths: json['new_deaths']==''?'0':json['new_deaths'],
        totalRecovered: json['total_recovered']==''?'0':json['total_recovered'],
        seriousCritical: json['serious_critical']==''?'0':json['serious_critical'],
        totalCasesperMil: json['total_cases_per1m']==''?'0':json['total_cases_per1m'],
        recordDate:json['record_date']==''?'0':json['record_date']);
  }

  @override
  String toString(){
    String liveStatToString = """LiveStat(totalCases=$totalCases,
                                          newCases=$newCases,
                                          activeCases=$activeCases,
                                          totalDeaths=$totalDeaths,
                                          newDeaths=$newDeaths,
                                          totalRecovered=$totalRecovered,
                                          seriousCritical=$seriousCritical,
                                          totalCasesperMil=$totalCasesperMil,
                                          recordDate=$recordDate)""";
    return liveStatToString;
  }

  @override
  List<Object> get props => [
        totalCasesperMil,
        totalCases,
        newCases,
        activeCases,
        totalDeaths,
        newDeaths,
        totalRecovered,
        seriousCritical
      ];
}
