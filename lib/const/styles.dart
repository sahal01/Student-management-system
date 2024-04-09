import 'package:flutter/material.dart';

class Styles {
  normalS(
      {required FontWeight fontW,
        required double fontS,
        required Color color,
        required String fontFamily}) {
    return TextStyle(
        fontSize: fontS,
        fontWeight: fontW,
        color: color,
        fontFamily: fontFamily);
  }

  letterSpacing(
      {required FontWeight fontW,
        required double fontS,
        required Color color,
        required String fontFamily,
        required double spacing}) {
    return TextStyle(
        fontSize: fontS,
        fontWeight: fontW,
        color: color,
        fontFamily: fontFamily,
        letterSpacing: spacing);
  }

  lineGapS(
      {required FontWeight fontW,
        required double fontS,
        required Color color,
        required String fontFamily,
        required double height}) {
    return TextStyle(
        fontSize: fontS,
        fontWeight: fontW,
        color: color,
        height: height,
        fontFamily: fontFamily);
  }

}
