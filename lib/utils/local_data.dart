import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/utils/text_constant.dart';
import 'package:weather_app/model/weather/weather_model.dart';
import 'package:weather_app/model/main/main_model.dart';

class LocalData{

  static Future<bool> removeAllPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static void saveCoord(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TextConstant.coord, val);
  }

  static Future<String> getCoord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(TextConstant.coord);
    if (data != null && data.isNotEmpty) {
      return data;
    }
    return '';
  }

  static Future<bool> removeCoord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(TextConstant.coord);
  }

  static void saveWeather(WeatherModel val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TextConstant.weather, json.encode(val.toJson()));
  }

  static Future<WeatherModel> getWeather() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(TextConstant.weather);
    if (data != null && data.isNotEmpty) {
      return WeatherModel.fromJson(json.decode(data));
    }
    return null;
  }

  static Future<bool> removeWeather() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(TextConstant.weather);
  }

  static void saveTemperature(MainModel val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TextConstant.temperature, json.encode(val.toJson()));
  }

  static Future<MainModel> getTemperaturer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(TextConstant.temperature);
    if (data != null && data.isNotEmpty) {
      return MainModel.fromJson(json.decode(data));
    }
    return null;
  }

  static Future<bool> removeTemperature() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(TextConstant.temperature);
  }

  static void saveDaily(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TextConstant.daily, val);
  }

  static Future<String> getDaily() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(TextConstant.daily);
    if (data != null && data.isNotEmpty) {
      return data;
    }
    return '';
  }

  static Future<bool> removeDaily() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(TextConstant.daily);
  }
}