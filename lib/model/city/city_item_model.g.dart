part of 'city_item_model.dart';
CityitemModel _$fromJson(Map<String, dynamic> json) {
  return CityitemModel()
    ..city = json['city'] as String ?? ''
    ..coord = json["coord"] == null ? null : CoordModel.fromJson(json["coord"] as Map<String, dynamic>)
    ..temperature = json["temperature"] == null ? null : MainModel.fromJson(json["temperature"] as Map<String, dynamic>)
    ..weather = json["weather"] == null ? null : WeatherModel.fromJson(json["weather"] as Map<String, dynamic>)
    ..daily =  (json['daily'] as List)?.map((e) => e == null ? null : DailyWeatherModel.fromJson(e as Map<String, dynamic>))?.toList()
  ;
}

Map<String, dynamic> _$toJson(CityitemModel instance) =>
    <String, dynamic>{
      'city': instance.city,
      'coord': instance.coord,
      'temperature': instance.temperature,
      'weather': instance.weather,
      'daily': instance.daily
    };