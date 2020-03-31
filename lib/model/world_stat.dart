import 'package:equatable/equatable.dart';

class WorldStat extends Equatable {
  final String totalCases;
  final String totalDeaths;
  final String totalRecovered;
  final String newCases;
  final String newDeaths;
  final String lastUpdate;

  WorldStat(
    this.totalCases,
    this.totalDeaths,
    this.newCases,
    this.totalRecovered,
    this.newDeaths,
    this.lastUpdate
  );

  factory WorldStat.fromJson(Map<String, dynamic> json) {
    return WorldStat(
      json['total_cases']??'0',
      json['total_deaths']??'0',
      json['new_cases']??'0',
      json['total_recovered']??'0',
      json['new_deaths']??'0',
      json['statistic_taken_at']??'Not Available!'
    );
  }

  @override
  List<Object> get props => [totalCases, totalDeaths, newCases, totalRecovered,newDeaths,lastUpdate];
}
