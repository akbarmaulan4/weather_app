part of 'daily_model.dart';
DailyWeatherModel _$fromJson(Map<String, dynamic> json) {
  return DailyWeatherModel()
    ..day = json['day'] as String ?? ''
    ..temp = json['temp'] as double ?? 0.0
    ..main = json['main'] as String ?? ''
    ..description = json['description'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(DailyWeatherModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'temp': instance.temp,
      'main': instance.main,
      'description': instance.description,
    };