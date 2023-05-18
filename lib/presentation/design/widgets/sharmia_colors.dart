import 'package:flutter/material.dart';

class SharmiaColors extends Color {
  // Constructor que llama al constructor de la clase Color
  SharmiaColors(int value) : super(value);

  static Color get sharmiaGreen =>
      Color(int.parse("#7BFF11".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaGreenBackground =>
      Color(int.parse("#F1FFEC".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaDarkGreen =>
      Color(int.parse("#417618".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaBlack =>
      Color(int.parse("#202020".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaBlack50 =>
      Color(int.parse("#808080".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaMediumGreen =>
      Color(int.parse("#5AAA1C".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaBlack20 =>
      Color(int.parse("#CCCCCC".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaWhite =>
      Color(int.parse("#FFFFFF".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaBlack5 =>
      Color(int.parse("#F3F3F3".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaRed =>
      Color(int.parse("#E91447".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaBlack80 =>
      Color(int.parse("#4D4D4D".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaGreenLight =>
      Color(int.parse("#DFFFC5".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaBlack90 =>
      Color(int.parse("#363636".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaUltraBlack =>
      Color(int.parse("#000000".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaBlack1 =>
      Color(int.parse("#FDFDFD".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaBlack3 =>
      Color(int.parse("#F8F8F8".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaBlack10 =>
      Color(int.parse("#E9E9E9".substring(1, 7), radix: 16) + 0xFF000000);
  static Color get sharmiaRedForDark =>
      Color(int.parse("#FFA7A7".substring(1, 7), radix: 16) + 0xFF000000);
}
