import 'package:flutter_guid/flutter_guid.dart';
import 'package:lomba_frontend/core/constants.dart';

import '../features/orgas/data/models/orga_model.dart';
import '../features/orgas/data/models/orgauser_model.dart';
import '../features/roles/data/models/role_model.dart';
import '../features/users/data/models/user_model.dart';

///Archivo con datos falsos para hacer funcionar el prototipo.

///Lista de ID volátiles de organizaciones (Orgas)
String fakeOrgaIdSystem = Guid.newGuid.toString();
String fakeOrgaIdRoot = Guid.newGuid.toString();
String fakeOrgaIdSample02 = Guid.newGuid.toString();
String fakeOrgaIdSample03 = Guid.newGuid.toString();

///Lista de ID volátiles de usuarios (Users)
String fakeUserIdSuperAdmin = Guid.newGuid.toString();
String fakeUserIdAdmin = Guid.newGuid.toString();
String fakeUserIdUser01 = Guid.newGuid.toString();
String fakeUserIdUser02 = Guid.newGuid.toString();
String fakeUserIdReviewer01 = Guid.newGuid.toString();

///Lista de [OrgaModel] con las organizaciones del sistema.
///
///Utiliza los ID creados anteriormente (más arriba)
List<OrgaModel> fakeListOrgas = <OrgaModel>[
  OrgaModel(
      id: fakeOrgaIdSystem,
      name: 'Sistema',
      code: 'sys',
      enabled: true,
      builtIn: true),
  OrgaModel(
      id: fakeOrgaIdRoot,
      name: 'Raíz',
      code: 'root',
      enabled: true,
      builtIn: false),
  OrgaModel(
      id: fakeOrgaIdSample02,
      name: 'Ejemplo 2',
      code: 'eje02',
      enabled: true,
      builtIn: false),
  OrgaModel(
      id: fakeOrgaIdSample03,
      name: 'Ejemplo 3',
      code: 'eje03',
      enabled: true,
      builtIn: false),
];

///Lista de relaciones de Orgas con Users y Roles, utiliza también
///los ID especificados arriba, junto con los Roles definidos del sistema.
List<OrgaUserModel> fakeListOrgaUsers = <OrgaUserModel>[
  OrgaUserModel(
      userId: fakeUserIdSuperAdmin,
      orgaId: fakeOrgaIdSystem,
      roles: const <String>[Roles.roleSuperAdmin],
      enabled: true,
      builtIn: true),
  OrgaUserModel(
      userId: fakeUserIdAdmin,
      orgaId: fakeOrgaIdRoot,
      roles: const <String>[Roles.roleAdmin],
      enabled: true,
      builtIn: false),
  OrgaUserModel(
      userId: fakeUserIdUser01,
      orgaId: fakeOrgaIdSample02,
      roles: const <String>[Roles.roleUser],
      enabled: true,
      builtIn: false),
  OrgaUserModel(
      userId: fakeUserIdUser02,
      orgaId: fakeOrgaIdSample03,
      roles: const <String>[Roles.roleUser],
      enabled: true,
      builtIn: false),
  OrgaUserModel(
      userId: fakeUserIdReviewer01,
      orgaId: fakeOrgaIdRoot,
      roles: const <String>[Roles.roleReviewer],
      enabled: true,
      builtIn: false)
];

///Lista de [UserModel] con usuarios fake para el prototipo. Utiliza también
///los ID especificados arriba para los usuarios de mentira.
List<UserModel> fakeListUsers = <UserModel>[
  UserModel(
      id: fakeUserIdSuperAdmin,
      name: 'Súper Administrador',
      username: 'sa',
      email: 'sa@mp.com',
      enabled: true,
      builtIn: true),
  UserModel(
      id: fakeUserIdAdmin,
      name: 'Administrador',
      username: 'admin',
      email: 'admin@mp.com',
      enabled: true,
      builtIn: false),
  UserModel(
      id: fakeUserIdUser01,
      name: 'Usuario 01',
      username: 'user1',
      email: 'user1@mp.com',
      enabled: true,
      builtIn: false),
  UserModel(
      id: fakeUserIdUser02,
      name: 'Usuario 02',
      username: 'user2',
      email: 'user2@mp.com',
      enabled: true,
      builtIn: false),
  UserModel(
      id: fakeUserIdReviewer01,
      name: 'Reviewer 01',
      username: 'rev1',
      email: 'rev1@mp.com',
      enabled: true,
      builtIn: false),
];

///Lista de Roles fake para utilizar con el listado de roles en el prototipo.
List<RoleModel> fakeRoles = [
  const RoleModel(name: Roles.roleSuperAdmin, enabled: true),
  const RoleModel(name: Roles.roleAdmin, enabled: true),
  const RoleModel(name: Roles.roleReviewer, enabled: true),
  const RoleModel(name: Roles.roleUser, enabled: true),
  const RoleModel(name: Roles.roleAnonymous, enabled: true)
];

class TestRandomItem {
  final String Id;
  final String name;
  final int num;
  final String text;

  TestRandomItem(this.Id, this.name, this.num, this.text);
}

final List<TestRandomItem> testRandomItemList = <TestRandomItem>[
  TestRandomItem("0", "cero", 0, "el cero"),
  TestRandomItem("1", "uno", 1, "el uno"),
  TestRandomItem("2", "dos", 2, "el dos"),
  TestRandomItem("3", "tres", 3, "el tres"),
  TestRandomItem("4", "cuatro", 4, "el cuatro"),
  TestRandomItem("5", "cinco", 5, "el cinco"),
  TestRandomItem("6", "seis", 6, "el seis"),
  TestRandomItem("7", "siete", 7, "el siete"),
  TestRandomItem("8", "ocho", 8, "el ocho"),
  TestRandomItem("9", "nueve", 9, "el nueve"),
  TestRandomItem("10", "diez", 10, "el diez"),
  TestRandomItem("11", "once", 11, "el once"),
  TestRandomItem("12", "doce", 12, "el doce"),
  TestRandomItem("13", "trece", 13, "el trece"),
  TestRandomItem("14", "catorce", 14, "el catorce"),
  TestRandomItem("15", "quince", 15, "el quince"),
  TestRandomItem("16", "dieciséis", 16, "el dieciséis"),
  TestRandomItem("17", "diecisiete", 17, "el diecisiete"),
  TestRandomItem("18", "dieciocho", 18, "el dieciocho"),
  TestRandomItem("19", "diecinueve", 19, "el diecinueve"),
  TestRandomItem("20", "veinte", 20, "el veinte"),
  TestRandomItem("21", "veintiuno,", 21, "el veintiuno,"),
  TestRandomItem("22", "veintidós", 22, "el veintidós"),
  TestRandomItem("23", "veintitrés", 23, "el veintitrés"),
  TestRandomItem("24", "veinticuatro", 24, "el veinticuatro"),
  TestRandomItem("25", "veinticinco", 25, "el veinticinco"),
  TestRandomItem("26", "veintiséis", 26, "el veintiséis"),
  TestRandomItem("27", "veintisiete", 27, "el veintisiete"),
  TestRandomItem("28", "veintiocho", 28, "el veintiocho"),
  TestRandomItem("29", "veintinueve", 29, "el veintinueve"),
  TestRandomItem("30", "treinta", 30, "el treinta"),
  TestRandomItem("31", "treinta y uno,", 31, "el treinta y uno,"),
  TestRandomItem("32", "treinta y una", 32, "el treinta y una"),
  TestRandomItem("33", "treinta y dos", 33, "el treinta y dos"),
  TestRandomItem("34", "treinta y tres", 34, "el treinta y tres"),
  TestRandomItem("35", "treinta y cuatro", 35, "el treinta y cuatro"),
  TestRandomItem("36", "treinta y cinco", 36, "el treinta y cinco"),
  TestRandomItem("37", "treinta y seis", 37, "el treinta y seis"),
  TestRandomItem("38", "treinta y ocho", 38, "el treinta y ocho"),
  TestRandomItem("39", "treinta y nueve", 39, "el treinta y nueve"),
  TestRandomItem("40", "cuarenta", 40, "el cuarenta"),
  TestRandomItem("41", "cuarenta y uno,", 41, "el cuarenta y uno,"),
  TestRandomItem("42", "cuarenta y dos", 42, "el cuarenta y dos"),
  TestRandomItem("43", "cuarenta y tres", 43, "el cuarenta y tres"),
  TestRandomItem("44", "cuarenta y cuatro", 44, "el cuarenta y cuatro"),
  TestRandomItem("45", "cuarenta y cinco", 45, "el cuarenta y cinco"),
  TestRandomItem("46", "cuarenta y seis", 46, "el cuarenta y seis"),
  TestRandomItem("47", "cuarenta y siete", 47, "el cuarenta y siete"),
  TestRandomItem("48", "cuarenta y ocho", 48, "el cuarenta y ocho"),
  TestRandomItem("49", "cuarenta y nueve", 49, "el cuarenta y nueve"),
  TestRandomItem("50", "cincuenta", 50, "el cincuenta"),
  TestRandomItem("51", "cincuenta y uno, cincuenta y una", 51,
      "el cincuenta y uno, cincuenta y una"),
  TestRandomItem("52", "cincuenta y dos", 52, "el cincuenta y dos"),
  TestRandomItem("53", "cincuenta y tres", 53, "el cincuenta y tres"),
  TestRandomItem("54", "cincuenta y cuatro", 54, "el cincuenta y cuatro"),
  TestRandomItem("55", "cincuenta y cinco", 55, "el cincuenta y cinco"),
  TestRandomItem("56", "cincuenta y seis", 56, "el cincuenta y seis"),
  TestRandomItem("57", "cincuenta y siete", 57, "el cincuenta y siete"),
  TestRandomItem("58", "cincuenta y ocho", 58, "el cincuenta y ocho"),
  TestRandomItem("59", "cincuenta y nueve", 59, "el cincuenta y nueve"),
  TestRandomItem("60", "sesenta", 60, "el sesenta"),
  TestRandomItem("61", "sesenta y uno, sesenta y una", 61,
      "el sesenta y uno, sesenta y una"),
  TestRandomItem("62", "sesenta y dos", 62, "el sesenta y dos"),
  TestRandomItem("63", "sesenta y tres", 63, "el sesenta y tres"),
  TestRandomItem("64", "sesenta y cuatro", 64, "el sesenta y cuatro"),
  TestRandomItem("65", "sesenta y cinco", 65, "el sesenta y cinco"),
  TestRandomItem("66", "sesenta y seis", 66, "el sesenta y seis"),
  TestRandomItem("67", "sesenta y siete", 67, "el sesenta y siete"),
  TestRandomItem("68", "sesenta y ocho", 68, "el sesenta y ocho"),
  TestRandomItem("69", "sesenta y nueve", 69, "el sesenta y nueve"),
  TestRandomItem("70", "setenta", 70, "el setenta"),
  TestRandomItem("71", "setenta y uno, setenta y una", 71,
      "el setenta y uno, setenta y una"),
  TestRandomItem("72", "setenta y dos", 72, "el setenta y dos"),
  TestRandomItem("73", "setenta y tres", 73, "el setenta y tres"),
  TestRandomItem("74", "setenta y cuatro", 74, "el setenta y cuatro"),
  TestRandomItem("75", "setenta y cinco", 75, "el setenta y cinco"),
  TestRandomItem("76", "setenta y seis", 76, "el setenta y seis"),
  TestRandomItem("77", "setenta y siete", 77, "el setenta y siete"),
  TestRandomItem("78", "setenta y ocho", 78, "el setenta y ocho"),
  TestRandomItem("79", "setenta y nueve", 79, "el setenta y nueve"),
  TestRandomItem("80", "ochenta", 80, "el ochenta"),
  TestRandomItem("81", "ochenta y uno, ochenta y una", 81,
      "el ochenta y uno, ochenta y una"),
  TestRandomItem("82", "ochenta y dos", 82, "el ochenta y dos"),
  TestRandomItem("83", "ochenta y tres", 83, "el ochenta y tres"),
  TestRandomItem("84", "ochenta y cuatro", 84, "el ochenta y cuatro"),
  TestRandomItem("85", "ochenta y cinco", 85, "el ochenta y cinco"),
  TestRandomItem("86", "ochenta y seis", 86, "el ochenta y seis"),
  TestRandomItem("87", "ochenta y siete", 87, "el ochenta y siete"),
  TestRandomItem("88", "ochenta y ocho", 88, "el ochenta y ocho"),
  TestRandomItem("89", "ochenta y nueve", 89, "el ochenta y nueve"),
  TestRandomItem("90", "noventa", 90, "el noventa"),
  TestRandomItem("91", "noventa y uno, noventa y una", 91,
      "el noventa y uno, noventa y una"),
  TestRandomItem("92", "noventa y dos", 92, "el noventa y dos"),
  TestRandomItem("93", "noventa y tres", 93, "el noventa y tres"),
  TestRandomItem("94", "noventa y cuatro", 94, "el noventa y cuatro"),
  TestRandomItem("95", "noventa y cinco", 95, "el noventa y cinco"),
  TestRandomItem("96", "noventa y seis", 96, "el noventa y seis"),
  TestRandomItem("97", "noventa y siete", 97, "el noventa y siete"),
  TestRandomItem("98", "noventa y ocho", 98, "el noventa y ocho"),
  TestRandomItem("99", "noventa y nueve", 99, "el noventa y nueve"),
  TestRandomItem("100", "cien", 100, "el cien"),
];
