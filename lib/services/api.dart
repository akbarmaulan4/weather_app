
import 'dart:convert';

import 'package:dio/dio.dart';

class API{

  static const baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String baseUrlOneCallApi = 'http://api.openweathermap.org/data/2.5/forecast?id=524901&appid=';
  static const String apiKeyWeather = 'e06bfab2f1528f8ae53b777c6d019f17';

  static getLocation(String kota, void callback(dynamic, Exception)) async {
    final requestUrl = '$baseUrl/weather?q=$kota&APPID=$apiKeyWeather';
    print('POST $requestUrl');
    try{
      var response = await Dio().get(requestUrl);
      if(response != null){
        print('RESULT ${json.encode(response.data)}');;
        int responseCode = response.data['status'];
        // if(responseCode == 200){
        callback(response, null);
        // }else{
        //   callback(null, response);
        // }
      }
    }catch(e){
      callback(null, 'error');
    }

  }

  static getWeather(double lat, double lon, void callback(dynamic, Exception)) async {
    final requestUrl = '$baseUrl/onecall?lat=${lat}&lon=${lon}&exclude=hourly,minutely&APPID=$apiKeyWeather';
    print('POST $requestUrl');
    try{
      var response = await Dio().get(requestUrl);
      if(response != null){
        print('RESULT ${json.encode(response.data)}');;
        // int responseCode = response.data['status'];
        // if(responseCode == 200){
        callback(response, null);
        // }else{
        //   callback(null, response);
        // }
      }
    }catch (e){
      callback(null, 'error');
    }

  }
}