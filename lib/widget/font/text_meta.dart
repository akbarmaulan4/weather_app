import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextMeta extends Text{
  final double size;
  final Color color;
  final TextAlign textAlign;
  final FontWeight weight;
  final int maxLines;
  TextMeta(String data, {
    this.size,
    this.color,
    this.textAlign = TextAlign.left,
    this.weight = FontWeight.normal,
    this.maxLines = 1
  }) : super(data,
      textAlign: textAlign,
      maxLines: maxLines,//isCentered ? TextAlign.center : TextAlign.left,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: 1.0,
      style: GoogleFonts.lato(
        fontSize: size,
        fontWeight: weight,
        color: color
      )
  );
}