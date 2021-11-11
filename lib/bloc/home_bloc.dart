
import 'dart:convert';

import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/model/daily/daily_model.dart';
import 'package:weather_app/model/main/main_model.dart';
import 'package:weather_app/model/weather/weather_model.dart';
import 'package:weather_app/services/api.dart';
import 'package:weather_app/utils/Utils.dart';
import 'package:weather_app/utils/local_data.dart';

class HomeBloc{
  final _messageError = BehaviorSubject<String>();
  final _city = BehaviorSubject<String>();
  final _currLoc = BehaviorSubject<Position>();
  final _weather = BehaviorSubject<WeatherModel>();
  final _temperatur = BehaviorSubject<MainModel>();
  final _isDay = BehaviorSubject<bool>();
  final _daily = BehaviorSubject<List<DailyWeatherModel>>();
  final _lastUpdate = BehaviorSubject<DateTime>();

  Stream<String> get messageError => _messageError.stream;
  Stream<String> get city => _city.stream;
  Stream<Position> get currLoc => _currLoc.stream;
  Stream<WeatherModel> get weather => _weather.stream;
  Stream<MainModel> get temperatur => _temperatur.stream;
  Stream<bool> get isDay => _isDay.stream;
  Stream<List<DailyWeatherModel>> get daily => _daily.stream;
  Stream<DateTime> get lastUpdate => _lastUpdate.stream;

  getCurrentLocation() async{
    Position pos = await Utils.getCurrentLocation();
    if(pos != null){
      Coordinates coordinates = Coordinates(pos.latitude, pos.longitude);
      var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      String city = address.first.adminArea;
      getlocationByCity(city);
      _city.sink.add(city);
      // _currLoc.sink.add(pos);
    }
  }

  getWeather(double lat, double lon){
    API.getWeather(lat, lon, (result, error) {
      if(result != null){
        List<DailyWeatherModel> dailyWeather = [];
        var daily = result.data['daily'] as List;
        if(daily != null){
          for(int i=1; i<daily.length; i++){
            var object = daily[i];
            var nameOfDay = DateFormat('EEE').format(DateTime.fromMillisecondsSinceEpoch(object['dt'] * 1000, isUtc: true));
            double temp = object['temp']['day']as double;
            var weather = object['weather'];

            DailyWeatherModel model = DailyWeatherModel();
            model.day = nameOfDay;
            model.temp = temp;
            model.main =  weather[0]['main'];
            model.description = weather[0]['description'];
            dailyWeather.add(model);
          }
          LocalData.removeDaily();
          LocalData.saveDaily(jsonEncode(dailyWeather));
          _daily.sink.add(dailyWeather);
        }
      }
    });
  }

  getlocationByCity(String city) {
    API.getLocation(city, (result, error) async {
      if(error != null){
        WeatherModel weather = await LocalData.getWeather();
        MainModel mainModel = await LocalData.getTemperaturer();
        String daily = await LocalData.getDaily();
        var coord = await LocalData.getCoord();
        if(weather != null){
          _weather.sink.add(weather);
        }
        if(mainModel != null){
          _temperatur.sink.add(mainModel);
        }
        if(daily != ''){
          String data = await LocalData.getDaily();
          var strDaily = json.decode(data);
          if(strDaily != null){
            var dsa = (strDaily as List)?.map((e) => e == null ? null : DailyWeatherModel.fromJson(e as Map<String, dynamic>))?.toList();
            _daily.sink.add(dsa);
          }
        }
        if(coord != null){
          var dataCoord = json.decode(coord);
          Position pos = Position(longitude: dataCoord['lon'], latitude: dataCoord['lat']);
          _currLoc.sink.add(pos);
        }
      }
      if(result != null){
        var coord = result.data['coord'];
        var weather = result.data['weather'];
        var main = result.data['main'];
        if(coord != null){
          Position pos = Position(longitude: coord['lon'], latitude: coord['lat']);
          getWeather(coord['lat'], coord['lat']);
          _currLoc.sink.add(pos);

          LocalData.removeCoord();
          LocalData.saveCoord(json.encode(result.data['coord']));
        }
        if(weather != null){
          WeatherModel model = WeatherModel.fromJson(weather[0] as Map<String, dynamic>);
          if(model != null){
            LocalData.removeWeather();
            LocalData.saveWeather(model);
            _weather.sink.add(model);
          }
        }
        if(main != null){
          MainModel model = MainModel.fromJson(main as Map<String, dynamic>);
          if(model != null){
            LocalData.removeTemperature();
            LocalData.saveTemperature(model);
            _temperatur.sink.add(model);
          }
        }

        var nameOfDay = DateFormat('EEE').format(DateTime.fromMillisecondsSinceEpoch(result.data['dt'] * 1000, isUtc: true));
        DateTime dateUpdate = DateTime.fromMillisecondsSinceEpoch(result.data['dt'] * 1000, isUtc: true);
        _lastUpdate.sink.add(dateUpdate);

        var date = DateTime.fromMillisecondsSinceEpoch(result.data['dt'] * 1000,
            isUtc: true);

        var sunrise = DateTime.fromMillisecondsSinceEpoch(
            result.data['sys']['sunrise'] * 1000,
            isUtc: true);

        var sunset = DateTime.fromMillisecondsSinceEpoch(
            result.data['sys']['sunset'] * 1000,
            isUtc: true);

        bool isDay = date.isAfter(sunrise) && date.isBefore(sunset);
        _isDay.sink.add(isDay);
      }
    });
  }



}