class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'cc95d932d5a45d33a9527d5019475f2c';
  static String currentWeatherByName(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}

class SystemKeys {
  static const String jwtsecretkey = "lomba";
  static const String token20221230 =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxIiwidXNlck5hbWUiOiJtcEBtcC5jb20iLCJleHAiOiIyMDIyLTEyLTMwIn0.tjQEaiBkWX2jIfzq1AqkfHEEPBsD_jQFVDfM8A-O6M8";
  static const String token2030 =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxIiwidXNlck5hbWUiOiJtcEBtcC5jb20iLCJleHAiOiIyMDMwLTEyLTMwIn0.DdeP9YJ4lWZHYVH44hfyVTRRItLdBM5FQDr99Rwj2SI";
  static const String tokenWrong =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6Im1wQG1wLmNvbSIsImV4cCI6IjIwMjItMTEtMzAifQ.CxFOYF1ZAsnZTdsQD_kos9Fdq_XddOpTUBVKjyCuGlw";
}
