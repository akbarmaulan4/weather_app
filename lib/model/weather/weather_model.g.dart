part of 'weather_model.dart';
WeatherModel _$fromJson(Map<String, dynamic> json) {
  return WeatherModel()
    ..id = json['id'] as int ?? -1
    ..main = json['main'] as String ?? ''
    ..description = json['description'] as String ?? ''
    ..icon = json['icon'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(WeatherModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };