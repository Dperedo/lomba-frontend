import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static bool _isDarkmode = true;
  static int maxScreen = 1200;
  static int paddingLeft = 50;
  static int paddingRight = 50;
  static const String baseUrl = 'http://localhost:8187';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isDarkmode {
    return _prefs.getBool('isDarkmode') ?? _isDarkmode;
  }

  static set isDarkmode(bool value) {
    _isDarkmode = value;
    _prefs.setBool('isDarkmode', value);
  }
}
