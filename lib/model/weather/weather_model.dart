part 'weather_model.g.dart';
class WeatherModel{
  WeatherModel(){}
  int id;
  String main;
  String description;
  String icon;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}