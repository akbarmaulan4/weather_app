import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'color_code.dart';
import 'constant_style.dart';

class Utils{

  static bool isNumeric(String s) {
    if(s == null) {
      return false;
    }

    // TODO according to DartDoc num.parse() includes both (double.parse and int.parse)
    return double.parse(s, (e) => null) != null ||
        int.parse(s, onError: (e) => null) != null;
  }

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static formatCurrency(double currency) {
    var curr = currency == null ? 0.0 : currency;
    if (curr < 0) {
      curr = 0;
    }
    NumberFormat numberFormat = NumberFormat("#,##0", "en_US");
    return "Rp " + numberFormat.format(curr); //.replaceAll(",", ".");
  }

  static formatCurrencyCustom(String mark, double currency) {
    var curr = currency == null ? 0.0 : currency;
    if (curr < 0) {
      curr = 0;
    }
    NumberFormat numberFormat = NumberFormat("#,##0", "en_US");
    return mark + numberFormat.format(curr); //.replaceAll(",", ".");
  }

  static convertNumberToK(double  val){
    var formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '', // if you want to add currency symbol then pass that in this else leave it empty.
    ).format(val);

    return formattedNumber.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), '');
  }

  static void log(Object obj) {
    print(obj);
  }

  static void alertError(BuildContext context, String message, void callback()) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: null,
            content: new Text(message),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK",
                    style: TextStyle(
                        color: colorFromHex(ColorCode.bluePrimary))),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (callback != null) {
                    callback();
                  }
                },
              )
            ],
          );
        });
  }

  static void infoDialog(BuildContext context, String title, String message, void callback()) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: new Text(message),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK",
                    style: TextStyle(
                        color: colorFromHex(ColorCode.colorPrimary))),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (callback != null) {
                    callback();
                  }
                },
              )
            ],
          );
        });
  }

  static progressDialog(BuildContext context){
    // FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            content: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 35,
                        height: 35,
                      ),
                      SizedBox(width: 20),
                      Text('Progress...', style: TextStyle(fontSize: 20),)
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  static progressDialog2(BuildContext context, String informasi){
    // FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            content: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 35,
                        height: 35,
                      ),
                      SizedBox(width: 20),
                      Text(informasi, style: TextStyle(fontSize: 20),)
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  // static Future<File> fixExifRotation(String imagePath) async {
  //   final originalFile = File(imagePath);
  //   List<int> imageBytes = await originalFile.readAsBytes();
  //
  //   final originalImage = img.decodeImage(imageBytes);
  //
  //   final height = originalImage.height;
  //   final width = originalImage.width;
  //
  //   // Let's check for the image size
  //   if (height >= width) {
  //     // I'm interested in portrait photos so
  //     // I'll just return here
  //     return originalFile;
  //   }
  //
  //   // We'll use the exif package to read exif data
  //   // This is map of several exif properties
  //   // Let's check 'Image Orientation'
  //   final exifData = await readExifFromBytes(imageBytes);
  //
  //   img.Image fixedImage;
  //
  //   if (height < width) {
  //     // rotate
  //     if (exifData['Image Orientation'].printable.contains('Horizontal')) {
  //       fixedImage = img.copyRotate(originalImage, 90);
  //     } else if (exifData['Image Orientation'].printable.contains('180')) {
  //       fixedImage = img.copyRotate(originalImage, -90);
  //     }else if (exifData['Image Orientation'].printable.contains('Rotated 90 CW')) {
  //       fixedImage = img.copyRotate(originalImage, 90);
  //     } else {
  //       fixedImage = img.copyRotate(originalImage, 0);
  //     }
  //   }
  //
  //   // Here you can select whether you'd like to save it as png
  //   // or jpg with some compression
  //   // I choose jpg with 100% quality
  //   final fixedFile =
  //   await originalFile.writeAsBytes(img.encodeJpg(fixedImage));
  //
  //   return fixedFile;
  // }

  static dialogMessage({BuildContext context, String title, Function ok}){
    var size = MediaQuery.of(context).size;
    FocusScope.of(context).requestFocus(FocusNode());
    bool kecil = false;
    if(size.height < 650){
      kecil = true;
    }else{
      kecil = false;
    }
    showDialog(
        context: context,
        builder: (contex){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            content: Container(
              height: kecil ? size.height * 0.12:size.height * 0.09,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextAvenir(title, color: Utils.colorFromHex(ColorCode.bluePrimary), size: kecil ? 13:14,),
                  Text('Apakah anda yakin ingin keluar aplikasi?', style: TextStyle(color: Utils.colorFromHex(ColorCode.bluePrimary), fontSize: kecil ? 13:14),),
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: kecil ? size.width * 0.23:size.width * 0.20,
                          decoration: ConstantStyle.boxButton(color: Colors.grey[200], radius: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          child: Center(
                            child: Text('Tidak', style: TextStyle(color: Utils.colorFromHex(ColorCode.bluePrimary), fontSize: kecil ? 13:14),),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          ok();
                        },
                        child: Container(
                          width: kecil ? size.width * 0.23:size.width * 0.20,
                          decoration: ConstantStyle.boxButton(color: Utils.colorFromHex(ColorCode.blueSecondary), radius: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          child: Center(
                            child: Text('Ya', style: TextStyle(color: Colors.white, fontSize: kecil ? 13:14),),
                          ),
                        ),
                      )
                    ],
                  )
                  // TextAvenir('Hapus Semua Notifkasi ?'),
                ],
              ),
            ),
          );
        }
    );
  }

  static dialogInfo({BuildContext context, String title, Function ok}){
    var size = MediaQuery.of(context).size;
    bool kecil = false;
    if(size.height < 650){
      kecil = true;
    }else{
      kecil = false;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
        context: context,
        builder: (contex){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            content: Container(
              height: kecil ? size.height * 0.12:size.height * 0.09,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextAvenir(title, color: Utils.colorFromHex(ColorCode.bluePrimary), size: kecil ? 13:14,),
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          ok();
                        },
                        child: Container(
                          width: kecil ? size.width * 0.23:size.width * 0.20,
                          decoration: ConstantStyle.boxButton(color: Utils.colorFromHex(ColorCode.blueSecondary), radius: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          child: Center(
                            // child: TextAvenir('Ya', color: Colors.white, size: kecil ? 13:14),
                          ),
                        ),
                      )
                    ],
                  )
                  // TextAvenir('Hapus Semua Notifkasi ?'),
                ],
              ),
            ),
          );
        }
    );
  }

  static void showConfirmDialog(BuildContext context, String title, String message, void callback()) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: new Text(message),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Tidak",
                    style: TextStyle(
                        color: colorFromHex(ColorCode.colorPrimary))),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Ya",
                    style: TextStyle(
                        color: colorFromHex(ColorCode.colorPrimary))),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (callback != null) {
                    callback();
                  }
                },
              )
            ],
          );
        });
  }


  static formatFileSize(double size) {
    String hrSize = null;

    double b = size;
    double k = size/1024.0;
    double m = ((size/1024.0)/1024.0);
    double g = (((size/1024.0)/1024.0)/1024.0);
    double t = ((((size/1024.0)/1024.0)/1024.0)/1024.0);

    NumberFormat dec = new NumberFormat("0.00");

    if ( t>1 ) {
      hrSize = '${dec.format(t)} TB';//.concat(" TB");
    } else if ( g>1 ) {
      hrSize = '${dec.format(g)} GB';//.concat(" GB");
    } else if ( m>1 ) {
      hrSize ='${dec.format(m)} MB';//.concat(" MB");
    } else if ( k>1 ) {
      hrSize = '${dec.format(k)} KB';//.concat(" KB");
    } else {
      hrSize = '${dec.format(b)} Bytes';//.concat(" Bytes");
    }

    return hrSize;
  }

  static calculateVPS(String expiredDate){
    DateTime dt = DateTime.parse(expiredDate);
    var days = daysBetween(DateTime.now(), dt);
    return days;
  }

  static daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static getUniqueCodeDate(){
    var now = new DateTime.now();
    var formatter = new DateFormat('ddMMyyHHmmss');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static Future<Position> getCurrentLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if(position != null){
      return position;
    }
  }



  static double celsiusToFahrenheit(double celsius) {
    return celsius * 1.8 + 32.0;
  }

  static double celsiusToKelvin(double celsius) {
    return celsius + 273.15;
  }


  static double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32.0) / 1.8;
  }

  static double fahrenheitToKelvin(double fahrenheit) {
    return (fahrenheit + 459.67) * (5.0 / 9.0);
  }


  static double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  static double kelvinToFahrenheit(double kelvin) {
    return kelvin * (9.0 / 5.0) - 459.67;
  }
}