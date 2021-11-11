part 'main_model.g.dart';
class MainModel{
  MainModel(){}
  double temp;
  double feels_like;
  double temp_min;
  double temp_max;
  int pressure;
  int humidity;

  factory MainModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}