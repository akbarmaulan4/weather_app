
import 'package:flutter/material.dart';

class ConstantStyle {

  // static const styleLabel = TextStyle(
  //     fontSize: 14,
  //     color: Utils.colorFromHex(ColorCode.bluePrimary)
  // );

  static const avenirStandart = TextStyle(
    fontFamily: 'Avenir',
    fontSize: 14,
    color: Colors.grey,
  );

  static const decorTextField = InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(bottom:16),
  );

  static decorTextField2(String hint){
    return InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(bottom:16)
    );
  }

  static box_card() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            offset: Offset(1,1),
          )
        ]
    );
  }

  static boxShadowButon({
    double radius,
    Color color,
    Color colorShadow,
    double spreadRadius,
    double blurRadius,
    Offset offset,
  }){
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      color: color,
      boxShadow: [
        BoxShadow(
          color: colorShadow,
          spreadRadius: spreadRadius,
          blurRadius: blurRadius,
          offset: offset,
        ),
      ],
    );
  }

  static boxButton({
    double radius,
    Color color,
  }){
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: color
    );
  }

  static boxButtonBorder({
    double radius,
    Color color,
    Color colorBorder,
    double widthBorder
  }){
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      color: color,
      border: Border.all(color: colorBorder, width: widthBorder)
    );
  }

  static boxShadowButtonBorder({
    double radius,
    Color color,
    Color colorBorder,
    double widthBorder,
    Color colorShadow,
    double spreadRadius,
    double blurRadius,
    Offset offset,
  }){
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: color,
        border: Border.all(color: colorBorder, width: widthBorder),
        boxShadow: [
          BoxShadow(
            color: colorShadow,
            spreadRadius: spreadRadius,
            blurRadius: blurRadius,
            offset: offset,
          ),
        ],
    );
  }

  // static var box_white = BoxDecoration(
  //     color: Colors.white,
  //     borderRadius: BorderRadius.all(Radius.circular(10)),
  // );
  //
  // static var box_light_blue_dark = BoxDecoration(
  //     color: Utils.colorFromHex(ColorCode.blueSecondary),
  //     borderRadius: BorderRadius.all(Radius.circular(10)),
  //     border: Border.all(color: Colors.grey[300])
  // );
  //
  // static var box_fill_blu = BoxDecoration(
  //   color: Utils.colorFromHex(ColorCode.bluePrimary),
  //   borderRadius: BorderRadius.all(Radius.circular(25)),
  // );
  //
  // static var button_fill_blu = BoxDecoration(
  //   color: Utils.colorFromHex(ColorCode.bluePrimary),
  //   borderRadius: BorderRadius.all(Radius.circular(10)),
  // );
  //
  // static var box_fill_blue_nd = BoxDecoration(
  //     color: Utils.colorFromHex(ColorCode.blueSecondary),
  //     borderRadius: BorderRadius.all(Radius.circular(10)),
  // );
  //
  // // static var box_fill_green = BoxDecoration(
  // //   color: Utils.colorFromHex(ColorCode.greenElsimil),
  // //   borderRadius: BorderRadius.all(Radius.circular(10)),
  // // );
  //
  // static var box_fill_grey = BoxDecoration(
  //     color: Colors.grey[200],
  //     borderRadius: BorderRadius.all(Radius.circular(10)),
  // );
  //
  // static var box_fill_red = BoxDecoration(
  //   color: Colors.red,
  //   borderRadius: BorderRadius.all(Radius.circular(3)),
  // );
  //
  // // static var box_fill_green = BoxDecoration(
  // //   color: Colors.green,
  // //   borderRadius: BorderRadius.all(Radius.circular(10)),
  // // );
  //
  // static var box_border_grey = BoxDecoration(
  //     color: Colors.white,
  //     borderRadius: BorderRadius.all(Radius.circular(10)),
  //     border: Border.all(color: Colors.grey[300])
  // );
  //
  // static var box_border_field = BoxDecoration(
  //     borderRadius: BorderRadius.all(Radius.circular(5)),
  //     border: Border.all(color: Colors.grey[300])
  // );
}