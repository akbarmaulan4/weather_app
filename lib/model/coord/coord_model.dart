part 'coord_model.g.dart';
class CoordModel{
  CoordModel(){}
  double lon;
  double lat;

  factory CoordModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}