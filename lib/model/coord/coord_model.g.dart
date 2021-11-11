part of 'coord_model.dart';
CoordModel _$fromJson(Map<String, dynamic> json) {
  return CoordModel()
    ..lon = json['lon'] as double ?? 0.0
    ..lat = json['lat'] as double ?? 0.0
  ;
}

Map<String, dynamic> _$toJson(CoordModel instance) =>
    <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };