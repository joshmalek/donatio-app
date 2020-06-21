import 'package:flutter/cupertino.dart';

class ThemePalette {
  static const Color primary = Color(0xff0B1521);
  static const Color secondary1 = Color(0xff6DA3BF);
  static const Color secondary2 = Color(0xff5E8FA8);
  static const Color inverse = Color(0xffffffff);
  static const Color green = Color(0xff7BEE96);
  static const Color black = Color(0xff202020);
  static const Color shadow = Color.fromRGBO(0, 0, 0, 0.2);
  static const Color grey = Color(0xffB5B5B5);

  static Color alphaColor(Color base, double alphaValue) {
    return Color.fromRGBO(base.red, base.green, base.green, alphaValue);
  }
}

class FontPresets {
  static const TextStyle small = TextStyle(
      fontSize: 10,
      fontFamily: "OpenSans",
      fontWeight: FontWeight.normal,
      color: Color(0xff000000));

  static const TextStyle title1 = TextStyle(
      fontSize: 25,
      fontFamily: "Yan",
      fontWeight: FontWeight.w400,
      color: Color(0xff000000));

  static const TextStyle huge = TextStyle(
      fontSize: 70,
      fontFamily: "Yan",
      fontWeight: FontWeight.w400,
      color: Color(0xff000000));
}
