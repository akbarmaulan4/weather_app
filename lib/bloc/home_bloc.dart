
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/model/city/city_item_model.dart';
import 'package:weather_app/model/daily/daily_model.dart';
import 'package:weather_app/model/main/main_model.dart';
import 'package:weather_app/model/weather/weather_model.dart';
import 'package:weather_app/services/api.dart';
import 'package:weather_app/utils/Utils.dart';
import 'package:weather_app/utils/local_data.dart';
import 'package:weather_app/model/coord/coord_model.dart';

class HomeBloc{
  final _messageError = BehaviorSubject<String>();
  final _city = BehaviorSubject<String>();
  final _currLoc = BehaviorSubject<CoordModel>();
  final _weather = BehaviorSubject<WeatherModel>();
  final _temperatur = BehaviorSubject<MainModel>();
  final _isDay = BehaviorSubject<bool>();
  final _daily = BehaviorSubject<List<DailyWeatherModel>>();
  final _lastUpdate = BehaviorSubject<DateTime>();
  final _allCities = BehaviorSubject<List<CityitemModel>>();

  Stream<String> get messageError => _messageError.stream;
  Stream<String> get city => _city.stream;
  Stream<CoordModel> get currLoc => _currLoc.stream;
  Stream<WeatherModel> get weather => _weather.stream;
  Stream<MainModel> get temperatur => _temperatur.stream;
  Stream<bool> get isDay => _isDay.stream;
  Stream<List<DailyWeatherModel>> get daily => _daily.stream;
  Stream<DateTime> get lastUpdate => _lastUpdate.stream;
  Stream<List<CityitemModel>> get allCities => _allCities.stream;

  TextEditingController edtFind = TextEditingController();

  String _cityName = '';
  String get cityName => _cityName;

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

  getlocationByCity(String city) {
    API.getLocation(city, (result, error) async {
      if(error != null){
        WeatherModel weather = await LocalData.getWeather();
        MainModel mainModel = await LocalData.getTemperaturer();
        String daily = await LocalData.getDaily();
        CoordModel coord = await LocalData.getCoord();
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
          // var dataCoord = json.decode(coord);
          // Position pos = Position(longitude: dataCoord['lon'], latitude: dataCoord['lat']);
          _currLoc.sink.add(coord);
        }
      }
      
      if(result != null){
        
        CityitemModel cityModel = CityitemModel();
        cityModel.city = city;
        _cityName = city;
        _city.sink.add(city);

        var coord = result.data['coord'];
        var weather = result.data['weather'];
        var main = result.data['main'];
        
        if(weather != null){
          WeatherModel weatherModel = WeatherModel.fromJson(weather[0] as Map<String, dynamic>);
          if(weatherModel != null){
            cityModel.weather = weatherModel;
            LocalData.removeWeather();
            LocalData.saveWeather(weatherModel);
            _weather.sink.add(weatherModel);
          }
        }
        if(main != null){
          MainModel mainModel = MainModel.fromJson(main as Map<String, dynamic>);
          if(mainModel != null){
            cityModel.temperature = mainModel;
            LocalData.removeTemperature();
            LocalData.saveTemperature(mainModel);
            _temperatur.sink.add(mainModel);
          }
        }

        if(coord != null){
          CoordModel coordModel = CoordModel.fromJson(coord as Map<String, dynamic>);
          if(coordModel != null){
            cityModel.coord = coordModel;
            getWeather(coordModel.lat, coordModel.lon, cityModel);
            LocalData.removeCoord();
            LocalData.saveCoord(coordModel);
            _currLoc.sink.add(coordModel);
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



  getWeather(double lat, double lon, CityitemModel cityitemModel){
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
        cityitemModel.daily = dailyWeather;
        saveCities(cityitemModel.city, cityitemModel);
      }
    });
  }

  saveCities(String city, CityitemModel model) async{
    List<CityitemModel> cities = [];
    var data = await LocalData.getCities();
    if(data != ''){
      var dataJson = jsonDecode(data);
      if(dataJson != null){
        var listCities = (dataJson as List)?.map((e) => e == null ? null : CityitemModel.fromJson(e as Map<String, dynamic>))?.toList();
        listCities.removeWhere((element) => element.city == city);
        var allNotSame = listCities.where((element) => element.city != city).toList();
        if(allNotSame != null && allNotSame.length > 0){
          allNotSame.add(model);
          cities.addAll(allNotSame);
        }else{
          cities.add(model);
        }
      }
    }else{
      cities.add(model);
    }

    LocalData.saveCities(jsonEncode(cities));
  }

  getAllCities() async {
    var data = await LocalData.getCities();
    if(data != ''){
      var dataJson = jsonDecode(data);
      if(dataJson != null){
        var listCities = (dataJson as List)?.map((e) => e == null ? null : CityitemModel.fromJson(e as Map<String, dynamic>))?.toList();
        _allCities.sink.add(listCities);
      }
    }
  }

  showLocalHome(String city) async {
    var data = await LocalData.getCities();
    if(data != ''){
      var dataJson = jsonDecode(data);
      if(dataJson != null){
        var listCities = (dataJson as List)?.map((e) => e == null ? null : CityitemModel.fromJson(e as Map<String, dynamic>))?.toList();
        var cities = listCities.where((element) => element.city == city).toList();
        if(cities != null && cities.length > 0){
          CityitemModel model = cities[0];
          _city.sink.add(capitalize(city));
          _weather.sink.add(model.weather);
          _temperatur.sink.add(model.temperature);
          _currLoc.sink.add(model.coord);
          _daily.sink.add(model.daily);
        }
      }
    }
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  searchPlaceByQuery(String param) async {
    List<Address> response;
    Geocoder.local.findAddressesFromQuery(param).then((result){
      if(result != null){

      }
      response = result;
    }).catchError((onError){
      var osda = onError;
    });
  }



}