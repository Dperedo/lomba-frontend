///Conjunto de URLs y otros datos relacionados con el mockup inicial.
///
///Se conservan aún en el proyecto hasta cuando hagamos la integración
///hacia el backend. Por ahora siguen aquí, eliminaremos algunas claves
///y conservaremos la URL del endpoint del backend.
class UrlBackend {
  static const String base = String.fromEnvironment('API_BASE_URL',
      defaultValue: 'http://localhost:4001');
}

class FirebaseConfig {
  static const String webAPIKey = String.fromEnvironment('FIREBASE_WEB_APIKEY',
      defaultValue: 'AIzaSyBo04vjnwIMshIMpQBHPq97sJtmobaFCT4');
  static const String androidAPIKey = String.fromEnvironment(
      'FIREBASE_ANDROID_APIKEY',
      defaultValue: 'AIzaSyCoRSyoxNQW7smoQHMKZSSVstVDzfjGDbQ');
  static const String iosAPIKey = String.fromEnvironment('FIREBASE_IOS_APIKEY',
      defaultValue: 'AIzaSyCfK5iIcTbqKK9GQGxcw7-QJMOxvOYDlKM');
  static const String appId = String.fromEnvironment('FIREBASE_APP_ID',
      defaultValue: '1:697984302717:android:7a25ab9711f45594327b14');
  static const String messagingSenderId = String.fromEnvironment(
      'FIREBASE_MSG_SENDER_ID',
      defaultValue: '697984302717');
  static const String projectId = String.fromEnvironment('FIREBASE_PROJECT_ID',
      defaultValue: 'lomba-94302');
  static const String storageBucket = String.fromEnvironment(
      'FIREBASE_STORAGE_BUCKET',
      defaultValue: 'lomba-94302.appspot.com');
  static const String measurementId = String.fromEnvironment(
      'FIREBASE_MEASUREMENT_ID',
      defaultValue: 'G-V8LHBP5JL8');
  static const String authDomain = String.fromEnvironment(
      'FIREBASE_AUTH_DOMAIN',
      defaultValue: 'lomba-94302.firebaseapp.com');
  static const String iosClientId = String.fromEnvironment(
      'FIREBASE_IOS_CLIENT_ID',
      defaultValue:
          '697984302717-qq0u5gmp0ogl4e537en7pghflam21j7b.apps.googleusercontent.com');
  static const String iosBundleId = String.fromEnvironment(
      'FIREBASE_IOS_BUNDLE_ID',
      defaultValue: 'com.example.lombaFrontend');
}
/*

FIREBASE_WEB_APIKEY
FIREBASE_ANDROID_APIKEY
FIREBASE_IOS_APIKEY
FIREBASE_APP_ID
FIREBASE_MSG_SENDER_ID
FIREBASE_PROJECT_ID
FIREBASE_STORAGE_BUCKET
FIREBASE_MEASUREMENT_ID
FIREBASE_AUTH_DOMAIN
FIREBASE_IOS_CLIENT_ID
FIREBASE_IOS_BUNDLE_ID

*/

class ScreenSize {
  static const sizeMenuBox = 300.0;
  static const minBoxBody = 500.0;
  static const maxBoxBody = 650.0;
  static const minScreen = 500;
  static const maxScreen = 1200;
}

class snackBarConfig {
  static const snackbarDuration = 1500;
}

class StagesVotationFlow {
  static const stageId01Load = '00000AAA-0111-0111-0111-000000000111';
  static const stageId02Approval = '00000BBB-0111-0111-0111-000000000111';
  static const stageId03Voting = '00000CCC-0111-0111-0111-000000000111';
}

class Flows {
  static const votationFlowId = '00000111-0111-0111-0111-000000000111';
}

///Claves de sistema, como tokends creados en el sitio JWT.io.
///
///La intención es utilizar estos tokens en pruebas y el prototipo del sitio.
///Deberán ser eliminados una vez se tenga la integración co el backend.
class SystemKeys {
  static const String jwtsecretkey = "lomba";

  static const String tokenSuperAdmin2023 =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIwMDAwMDAwMS0wMDAxLTAwMDEtMDAwMS0wMDAwMDAwMDAwMDEiLCJvcmdhSWQiOiIwMDAwMDEwMC0wMTAwLTAxMDAtMDEwMC0wMDAwMDAwMDAxMDAiLCJyb2xlcyI6InN1cGVyIiwiaWF0IjoxNjczNDY2NjU1LCJleHAiOjI2NzM0NzAyNTV9.Vu5Rh6Y_lXOZ_Eu6AkZmu-kzo-2V7vaLkcm5t2CCTZE";
  static const String tokenUser012023 =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIwMDAwMDAwNS0wMDA1LTAwMDUtMDAwNS0wMDAwMDAwMDAwMDUiLCJvcmdhSWQiOiIwMDAwMDIwMC0wMjAwLTAyMDAtMDIwMC0wMDAwMDAwMDAyMDAiLCJyb2xlcyI6InVzZXIiLCJpYXQiOjE2NzM0NjY2NTUsImV4cCI6MjY3MzQ3MDI1NX0.rwn5MViF8hvfMvH8J2GDfRcm-y4ARQbl5_oxvPtQOnk";
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
  static const String tokenDoubleOrga =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIwMDAwMDAwNy0wMDA3LTAwMDctMDAwNy0wMDAwMDAwMDAwMDciLCJvcmdhSWQiOiIiLCJpYXQiOjE2Nzc1MTQxNjgsImV4cCI6MjY3NzUxNzc2OH0.rxtjiv4vQ714cRl21Mr9oX4sf2QYR5v_esxSX7pyXeU";
}

///Listado de las opciones posibles del menú lateral.
///
///Todas las nuevas opciones de menú deben se agregadas en este listado.
class SideDrawerUserOptions {
  static const String optRecent = "recent";
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
  static const String optDemoList = "demolist";
  static const String optDetailList = "detaillist";
  static const String optFlow = "flow";
  static const String optStage = "stage";
  static const String optSettingSuper = "settingsuper";
  static const String optSettingAdmin = "settingadmin";
}

class SettingCodes {
  static const String defaultOrgaForUserRegister = "defaultOrgaForUserRegister";
  static const String defaultRoleForUserRegister = "defaultRoleForUserRegister";
  static const String orgaForAnonymousUser = "orgaForAnonymousUser";
  static const String defaultFlow = "defaultFlow";
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

///Listado de páginas o boxes de Posts. Estos mismos nombres se manejan en Backend
class BoxPages {
  static const uploadedPosts = "uploaded";
  static const forApprovePosts = "forapprove";
  static const approvedPosts = "approved";
  static const rejectedPosts = "rejected";
  static const latestPosts = "latest";
  static const popularPosts = "popular";
  static const votedPosts = "voted";

  static List<String> toList() => [
        BoxPages.uploadedPosts,
        BoxPages.forApprovePosts,
        BoxPages.approvedPosts,
        BoxPages.rejectedPosts,
        BoxPages.latestPosts,
        BoxPages.popularPosts,
        BoxPages.votedPosts,
      ];
}
