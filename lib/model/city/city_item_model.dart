import 'package:weather_app/model/coord/coord_model.dart';
import 'package:weather_app/model/main/main_model.dart';
import 'package:weather_app/model/daily/daily_model.dart';
import 'package:weather_app/model/weather/weather_model.dart';
part 'city_item_model.g.dart';
class CityitemModel{
  CityitemModel(){}
  String city;
  CoordModel coord;
  MainModel temperature;
  WeatherModel weather;
  List<DailyWeatherModel> daily;

  factory CityitemModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}