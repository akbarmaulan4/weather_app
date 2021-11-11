import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/model/daily/daily_model.dart';
import 'package:weather_app/utils/Utils.dart';
import 'package:weather_app/utils/image_assets.dart';

import 'font/text_meta.dart';

class DailyWeatherWidget extends StatelessWidget {
  List<DailyWeatherModel> data = [];
  DailyWeatherWidget({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data.map((item) => Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Column(
                    children: [
                      TextMeta(item.day, size: 15, color: Colors.white,),
                      TextMeta('${item != null ? Utils.kelvinToCelsius(item.temp).round():'0'}°', color: Colors.white, weight: FontWeight.bold)
                    ]
                ),
                Container(
                  child: SvgPicture.asset(
                    getIconWeather(item.main),
                    semanticsLabel: '',
                    width: 40,
                    height: 40,
                  ),
                )
              ],
            ),
          )).toList(),
        ),
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
