import 'package:flutter/material.dart';
import 'package:weather_app/bloc/home_bloc.dart';
import 'package:weather_app/model/city/city_item_model.dart';
import 'package:weather_app/widget/font/text_meta.dart';

class AllCites extends StatefulWidget {
  @override
  _AllCitesState createState() => _AllCitesState();
}

class _AllCitesState extends State<AllCites> {
  HomeBloc bloc = HomeBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getAllCities();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextMeta('All Cities'),
      ),
      body: StreamBuilder(
        stream: bloc.allCities,
        builder: (context, snapshot) {
          List<CityitemModel> data =  [];
          if(snapshot.data != null){
            data = snapshot.data;
          }
          return Container(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey,
                );
              },
              itemBuilder: (context, index){
                return ListTile(
                  title: TextMeta(data[index].city),
                  onTap: ()=>Navigator.pushNamed(context, '/home_local', arguments: {'city': data[index].city}),
                );
              },
              scrollDirection: Axis.vertical,
              itemCount: data.length,
            ),
          );
        }
      ),
    );
  }
}
