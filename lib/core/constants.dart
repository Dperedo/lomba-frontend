///Conjunto de URLs y otros datos relacionados con el mockup inicial.
///
///Se conservan aún en el proyecto hasta cuando hagamos la integración
///hacia el backend. Por ahora siguen aquí, eliminaremos algunas claves
///y conservaremos la URL del endpoint del backend.
class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'cc95d932d5a45d33a9527d5019475f2c';
  static String currentWeatherByName(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}

class UrlBackend {
  static const String base = 'http://localhost:4001';
}

///Claves de sistema, como tokends creados en el sitio JWT.io.
///
///La intención es utilizar estos tokens en pruebas y el prototipo del sitio.
///Deberán ser eliminados una vez se tenga la integración co el backend.
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
  static const String tokenReviewed =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIyIiwicm9sZUlkIjoidXNlcixyZXZpZXdlZCIsImV4cCI6MTcwMzAxNTU0M30._r3SQKeYQf9KiZDsUTZOyljnFySHbamTeX4Lq3jPiHw";
}

///Listado de las opciones posibles del menú lateral.
///
///Todas las nuevas opciones de menú deben se agregadas en este listado.
class SideDrawerUserOptions {
  static const String optHome = "home";
  static const String optOrgas = "orgas";
  static const String optUsers = "users";
  static const String optRoles = "roles";
  static const String optLogIn = "login";
  static const String optLogOff = "logoff";
  static const String optProfile = "profile";
  static const String optToBeApproved = "tobeapproved";
  static const String optApproved = "approved";
  static const String optRejected = "rejected";
  static const String optAddContent = "addcontent";
  static const String optViewed = "viewed";
  static const String optPopular = "popular";
  static const String optUploaded = "uploaded";
}

///Listado de los roles del sistema. Por ahora pueden seguir en esta opción.
class Roles {
  static const String roleAnonymous = "anonymous";
  static const String roleSuperAdmin = "super";
  static const String roleAdmin = "admin";
  static const String roleReviewer = "reviewer";
  static const String roleUser = "user";

  static List<String> toList() => [
        Roles.roleAnonymous,
        Roles.roleUser,
        Roles.roleReviewer,
        Roles.roleAdmin,
        Roles.roleSuperAdmin
      ];
}
