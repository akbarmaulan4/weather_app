import 'package:flutter/material.dart';

class ContainerWeatherWidget extends StatelessWidget {
  String condition;
  bool isDay;
  Widget child;
  ContainerWeatherWidget({this.condition, this.isDay, this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: getIconWeather(condition, isDay),
          )
      ),
      child: child,
    );
  }

  getIconWeather(String condition, bool isDay) {
    if(!isDay){
      return [Colors.blueGrey, Colors.blueGrey.withOpacity(0.3)];
    }else{
      switch (condition) {
        case 'Thunderstorm':
          return [Colors.deepPurple, Colors.deepPurple.withOpacity(0.3)];
        case 'Drizzle':
          return [Colors.deepPurple, Colors.deepPurple.withOpacity(0.3)];
        case 'Rain':
          return [Colors.indigo, Colors.indigo.withOpacity(0.3)];
        case 'Snow':
          return [Colors.lightBlue, Colors.lightBlue.withOpacity(0.3)];
        case 'Clear':
          return [Colors.yellow, Colors.yellow.withOpacity(0.3)];
        case 'Clouds':
          return [Colors.indigo, Colors.indigo.withOpacity(0.3)];
        case 'Mist':
          return [Colors.indigo, Colors.indigo.withOpacity(0.3)];
        case 'fog':
          return [Colors.indigo, Colors.indigo.withOpacity(0.3)];
        case 'Smoke':
          return [Colors.indigo, Colors.indigo.withOpacity(0.3)];
        case 'Haze':
          return [Colors.blueGrey, Colors.blueGrey.withOpacity(0.3)];
        case 'Dust':
          return [Colors.brown, Colors.brown.withOpacity(0.3)];
        case 'Sand':
          return [Colors.brown, Colors.brown.withOpacity(0.3)];
        case 'Ash':
          return [Colors.brown, Colors.brown.withOpacity(0.3)];
        case 'Squall':
          return [Colors.brown, Colors.brown.withOpacity(0.3)];
        case 'Tornado':
          return [Colors.blueGrey, Colors.blueGrey.withOpacity(0.3)];
        default:
          return [Colors.lightBlue, Colors.lightBlue.withOpacity(0.3)];
      }
    }
  }
}
