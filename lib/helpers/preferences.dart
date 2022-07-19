import 'package:shared_preferences/shared_preferences.dart';
import 'package:front_lomba/providers/url_provider.dart';
import 'package:flutter/material.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static bool _isDarkmode = true;
  static int maxScreen = 1200;
  static int paddingLeft = 50;
  static int paddingRight = 50;
  static String baseUrl = '';
  //static String baseUrl = menuProvider as String;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    //flutter run --dart-define="APIURL=http://localhost:8187"
    const t = String.fromEnvironment("APIURL");
    buscarUrl(t);
  }

  static bool get isDarkmode {
    return _prefs.getBool('isDarkmode') ?? _isDarkmode;
  }

  static set isDarkmode(bool value) {
    _isDarkmode = value;
    _prefs.setBool('isDarkmode', value);
  }
}


