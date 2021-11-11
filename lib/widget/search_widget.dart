import 'package:flutter/material.dart';
import 'package:weather_app/utils/Utils.dart';
import 'package:weather_app/utils/color_code.dart';
import 'package:weather_app/utils/constant_style.dart';

class SearchWidget extends StatelessWidget {
  String hint;
  Function onChange;
  Function onClear;
  SearchWidget({this.hint, this.onChange, this.onClear});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ConstantStyle.boxButton(radius: 8, color: Utils.colorFromHex(ColorCode.soft_grey_meta)),
      child: TextField(
        // controller: edt,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            border: InputBorder.none,
            // contentPadding: EdgeInsets.only(bottom:16),
            hintStyle: TextStyle(color: Utils.colorFromHex(ColorCode.dark_green_meta)),
            hintText: hint != null ? hint : 'Cari kota...',
          prefixIcon: Icon(Icons.search_rounded, color: Utils.colorFromHex(ColorCode.dark_green_meta))
        ),
        // enabled: false,
        onChanged: (val){
          if(val.length > 0){
            onChange(val);
          }else{
            onClear(val);
          }
        },
      ),
    );
  }
}
