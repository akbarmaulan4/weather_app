import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/model/main/main_model.dart';
import 'package:weather_app/model/weather/weather_model.dart';
import 'package:weather_app/utils/Utils.dart';
import 'package:weather_app/utils/image_assets.dart';

import 'font/text_meta.dart';

class WeatherWidget extends StatelessWidget {
  MainModel mainData;
  WeatherModel weatherData;
  WeatherWidget({this.mainData, this.weatherData});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Column(
                  children: [
                    TextMeta('${mainData != null ? Utils.kelvinToCelsius(mainData.temp).round():'0'}°',
                        size: 60, weight: FontWeight.w300, color: Colors.white),
                    TextMeta('Feels Like ${mainData != null ? Utils.kelvinToCelsius(mainData.feels_like).round():'0'}°', color: Colors.white,)
                  ],
                ),
              ),
              Expanded(child: Container()),
              Container(
                child: SvgPicture.asset(
                  getIconWeather(weatherData != null ? weatherData.main : ''),
                  semanticsLabel: '',
                  width: 80,
                  height: 80,
                ),
              )
            ],
          ),
          SizedBox(height: size.height * 0.08),
          Center(
            child: TextMeta(weatherData != null ? weatherData.main : '', size: 60, weight: FontWeight.w300, color: Colors.white),
          ),
        ],
      ),
    );
  }

  getIconWeather(String condition) {
    switch (condition) {
      case 'Thunderstorm':
        return ImageAssets.ic_thunderstorm;
      case 'Drizzle':
        return ImageAssets.ic_lightrain;
      case 'Rain':
        return ImageAssets.ic_rainnyday;
      case 'Snow':
        return ImageAssets.ic_snow;
      case 'Clear':
        return ImageAssets.ic_sunny;
      case 'Clouds':
        return ImageAssets.ic_cloud;
      case 'Mist':
        return ImageAssets.ic_mist;
      case 'fog':
        return ImageAssets.ic_mist;
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Sand':
      case 'Ash':
      case 'Squall':
      case 'Tornado':
        return ImageAssets.ic_cloud;
      default:
        return ImageAssets.ic_sunny;
    }
  }
}
