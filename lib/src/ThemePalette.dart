import 'package:flutter/cupertino.dart';

class ThemePalette {
  static const Color primary = Color(0xff0B1521);
  static const Color secondary1 = Color(0xff6DA3BF);
  static const Color secondary2 = Color(0xff5E8FA8);
  static const Color inverse = Color(0xffffffff);
  static const Color green = Color(0xff7BEE96);
  static const Color green2 = Color(0xff52ECBD);
  static const Color black = Color(0xff202020);
  static const Color shadow = Color.fromRGBO(0, 0, 0, 0.2);
  static const Color grey = Color(0xffB5B5B5);
  static const Color red = Color(0xffFF7A7A);

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

  static const TextStyle title2 = TextStyle(
      fontSize: 20,
      fontFamily: "Yan",
      fontWeight: FontWeight.w400,
      color: Color(0xff000000));

  static const TextStyle huge = TextStyle(
      fontSize: 70,
      fontFamily: "Yan",
      fontWeight: FontWeight.w400,
      color: Color(0xff000000));

  static const TextStyle medium = TextStyle(
      fontSize: 45,
      fontFamily: "Yan",
      fontWeight: FontWeight.w400,
      color: Color(0xff000000));

  static const TextStyle buttonText = TextStyle(
      fontSize: 12,
      fontFamily: "OpenSans",
      fontWeight: FontWeight.normal,
      color: Color(0xffffffff));

  static const TextStyle label = TextStyle(
      fontSize: 13,
      fontFamily: "OpenSans",
      fontWeight: FontWeight.normal,
      color: Color(0xff000000));

  static TextStyle colorTransform(TextStyle fromStyle, Color newColor) {
    TextStyle newStyle = TextStyle(
        color: newColor,
        fontSize: fromStyle.fontSize,
        fontFamily: fromStyle.fontFamily,
        fontWeight: fromStyle.fontWeight);
    return newStyle;
  }

  static TextStyle weightTransform(TextStyle fromStyle, FontWeight newWeight) {
    TextStyle newStyle = TextStyle(
        color: fromStyle.color,
        fontSize: fromStyle.fontSize,
        fontFamily: fromStyle.fontFamily,
        fontWeight: newWeight);
    return newStyle;
  }
}
