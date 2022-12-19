import 'package:flutter_guid/flutter_guid.dart';
import 'package:lomba_frontend/core/constants.dart';

import '../features/orgas/data/models/orga_model.dart';
import '../features/orgas/data/models/orgauser_model.dart';
import '../features/roles/data/models/role_model.dart';
import '../features/users/data/models/user_model.dart';

String fakeOrgaIdSystem = Guid.newGuid.toString();
String fakeOrgaIdRoot = Guid.newGuid.toString();
String fakeOrgaIdSample02 = Guid.newGuid.toString();
String fakeOrgaIdSample03 = Guid.newGuid.toString();

String fakeUserIdSuperAdmin = Guid.newGuid.toString();
String fakeUserIdAdmin = Guid.newGuid.toString();
String fakeUserIdUser01 = Guid.newGuid.toString();
String fakeUserIdUser02 = Guid.newGuid.toString();

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
      builtIn: false)
];

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
];

List<RoleModel> fakeRoles = [
  const RoleModel(name: Roles.roleSuperAdmin, enabled: true),
  const RoleModel(name: Roles.roleAdmin, enabled: true),
  const RoleModel(name: Roles.roleUser, enabled: true),
  const RoleModel(name: Roles.roleAnonymous, enabled: true)
];
