import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'font/text_meta.dart';

class LocationWidget extends StatelessWidget {
  String city;
  Position pos;
  LocationWidget({this.city, this.pos});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextMeta(city != null ? city : '', size: 30, maxLines: 2, textAlign: TextAlign.center, color: Colors.white,)
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.location, size: 15, color: Colors.white,),
              SizedBox(width: 10),
              TextMeta(pos != null ? '${pos.longitude.toString()},':'0', size: 17, color: Colors.white,),
              SizedBox(width: 3),
              TextMeta(pos != null ? pos.latitude.toString():'0', size: 17, color: Colors.white,),
            ],
          )
        ],
      ),
    );
  }
}
