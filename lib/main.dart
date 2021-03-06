import 'package:flutter/material.dart';
import 'package:weather_app/screen/all_cities.dart';
import 'package:weather_app/screen/home.dart';
import 'package:weather_app/screen/home_local.dart';
import 'package:weather_app/screen/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      onGenerateRoute: (initial){
        switch(initial.name){
          case '/all_cities':
            return MaterialPageRoute(
                builder: (context){
                  return AllCites();
                },
                settings: RouteSettings());
          case '/home_local':
            return MaterialPageRoute(
                builder: (context){
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return HomeLocal(city: arguments['city'],);
                },
                settings: RouteSettings());
          default: return null;
        }
      }
    );
  }
}
