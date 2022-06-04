import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme;

  ThemeProvider({required bool isDarkmode})
      : currentTheme = isDarkmode ? ThemeData.dark() : ThemeData.light();

  setLightMode() {
    currentTheme = ThemeData.light();
    notifyListeners();
  }

  setDarkmode() {
    currentTheme = ThemeData.dark();
    notifyListeners();
  }

  Color getPrimaryColor() {
    return currentTheme.primaryColor;
  }

  Color getTextColor() {
    return currentTheme.backgroundColor;
  }

  Color getIndicatorColor() {
    return currentTheme.indicatorColor;
  }

  Color getHoverColor() {
    return currentTheme.hoverColor;
  }

  Color getFocusColor() {
    return currentTheme.focusColor;
  }
}
