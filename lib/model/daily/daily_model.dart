part 'daily_model.g.dart';
class DailyWeatherModel{
  DailyWeatherModel(){}

  String day;
  double temp;
  String main;
  String description;

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}