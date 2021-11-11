part of 'main_model.dart';
MainModel _$fromJson(Map<String, dynamic> json) {
  return MainModel()
    ..temp = json['temp'] as double ?? 0.0
    ..feels_like = json['feels_like'] as double ?? 0.0
    ..temp_min = json['temp_min'] as double ?? 0.0
    ..temp_max = json['temp_max'] as double ?? 0.0
    ..pressure = json['pressure'] as int ?? 0
    ..humidity = json['humidity'] as int ?? 0
  ;
}

Map<String, dynamic> _$toJson(MainModel instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feels_like,
      'temp_min': instance.temp_min,
      'temp_max': instance.temp_max,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
    };