import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/bloc/home_bloc.dart';
import 'package:weather_app/model/daily/daily_model.dart';
import 'package:weather_app/model/main/main_model.dart';
import 'package:weather_app/model/weather/weather_model.dart';
import 'package:weather_app/utils/Utils.dart';
import 'package:weather_app/utils/debouncher.dart';
import 'package:weather_app/utils/image_assets.dart';
import 'package:weather_app/widget/container_weather_widget.dart';
import 'package:weather_app/widget/daily_weather_widget.dart';
import 'package:weather_app/widget/last_update_widget.dart';
import 'package:weather_app/widget/location_widget.dart';
import 'package:weather_app/widget/font/text_meta.dart';
import 'package:weather_app/widget/pull_refresh_widget.dart';
import 'package:weather_app/widget/search_widget.dart';
import 'package:weather_app/widget/weather_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc bloc = HomeBloc();
  var debouncher = new Debouncer(milliseconds: 500);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: PullRefreshWidget(
          onRefresh: ()=>bloc.getCurrentLocation(),
          child: StreamBuilder(
            stream: bloc.weather,
            builder: (context, snapshot) {
              WeatherModel weather;
              if(snapshot.data != null){
                weather = snapshot.data;
              }
              return StreamBuilder(
                stream: bloc.isDay,
                builder: (context, snapshot) {
                  bool day = false;
                  if(snapshot.data != null){
                    day = snapshot.data;
                  }
                  return ContainerWeatherWidget(
                    condition: weather != null ? weather.main:'',
                    isDay: day,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            child: SearchWidget(
                              onChange: (val){
                                debouncher.run(() {
                                  if(val != ''){
                                    bloc.getlocationByCity(val);
                                  }
                                });
                              },
                              onClear: (){
                                bloc.getCurrentLocation();
                              },
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          StreamBuilder(
                            stream: bloc.city,
                            builder: (context, snapshot) {
                              String city = '';
                              if(snapshot.data != null){
                                city = snapshot.data;
                              }
                              return StreamBuilder(
                                stream: bloc.currLoc,
                                builder: (context, snapshot) {
                                  Position pos;
                                  if(snapshot.data != null){
                                    pos = snapshot.data;
                                  }
                                  return LocationWidget(
                                    city: city,
                                    pos: pos,
                                  );
                                }
                              );
                            },
                          ),
                          SizedBox(height: size.height * 0.08),
                          StreamBuilder(
                            stream: bloc.temperatur,
                            builder: (context, snapshot) {
                              MainModel temperatur;
                              if(snapshot.data != null){
                                temperatur = snapshot.data;
                              }
                              return Container(
                                child: WeatherWidget(mainData: temperatur, weatherData: weather),
                              );
                            }
                          ),
                          SizedBox(height: size.height * 0.14),
                          StreamBuilder(
                            stream: bloc.daily,
                            builder: (context, snapshot) {
                              List<DailyWeatherModel> data = [];
                              if(snapshot.data != null){
                                data = snapshot.data;
                              }
                              return Container(
                                child: DailyWeatherWidget(data: data),
                              );
                            }
                          ),
                          SizedBox(height: size.height * 0.05),
                          StreamBuilder(
                            stream: bloc.lastUpdate,
                            builder: (context, snapshot) {
                              DateTime date = DateTime.now();
                              if(snapshot.data != null){
                                date = snapshot.data;
                              }
                              return LastUpdateWidget(date: date);
                            }
                          )
                        ],
                      ),
                    ),
                  );
                }
              );
            }
          ),
        ),
      ),
    );
  }
}
