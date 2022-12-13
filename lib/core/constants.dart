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

  static const String tokenSuperAdmin2023 =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxIiwicm9sZUlkIjoic3VwZXJhZG1pbiIsImV4cCI6MTcwNDA2NzE5OX0.WBUPl-1vK01LkCewn0a6K-6EKDt7mrahcUfjr4W5Yi0";
  static const String tokenAdmin2023 =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxIiwicm9sZUlkIjoiYWRtaW4iLCJleHAiOjE3MDQwNjcxOTl9.f_XM5CmPiNEKSpdZFowXnETfX5c1wc5N1X47vI4h6C0";
  static const String tokenUser2023 =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxIiwicm9sZUlkIjoidXNlciIsImV4cCI6MTcwNDA2NzE5OX0.gOK5PV22LdvRMg-noIdA1Togw3vRVsgp5A3Lb_244FI";
  static const String tokenAnonymous2023 =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxIiwicm9sZUlkIjoiYW5vbnltb3VzIiwiZXhwIjoxNzA0MDY3MTk5fQ.FigSBrOAlYnFcBww2KM-nirf8zls0mQ4uOal5BkLwgQ";
  static const String tokenWithoutUserId =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlSWQiOiJ1c2VyIiwiZXhwIjoxNzA0MDY3MTk5fQ.4i1TJpgXGO5TiBTBXMTpR3FQpmlTEDtHLrMqx5g5juw";
  static const String tokenWithoutRoleId =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxIiwiZXhwIjoxNzA0MDY3MTk5fQ.SVIdYpY8MhRK86q-AslB0Ntvw8XraHrZ2l0TpLQRTRQ";
  static const String tokenExpiredSuperAdmin =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxIiwicm9sZUlkIjoic3VwZXJhZG1pbiIsImV4cCI6MTY0MDk5NTE5OX0.wvhDsCJGUwF0wicvn5sFh_t48nB6OWx92uhxC_tsfG0";
}

class SideDrawerUserOptions {
  static const String Home = "home";
  static const String Orgas = "orgas";
  static const String Users = "users";
  static const String Roles = "roles";
  static const String LogIn = "login";
  static const String LogOff = "logoff";
  static const String Profile = "profile";
}

class Roles {
  static const String Anonymous = "anonymous";
  static const String SuperAdmin = "superadmin";
  static const String Admin = "admin";
  static const String User = "user";

  static List<String> toList() =>
      [Roles.Anonymous, Roles.User, Roles.Admin, Roles.SuperAdmin];
}
