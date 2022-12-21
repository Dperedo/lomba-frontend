import 'package:lomba_frontend/core/fakedata.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/exceptions.dart';

import 'package:http/http.dart' as http;

import '../models/role_model.dart';

abstract class RoleRemoteDataSource {
  Future<List<RoleModel>> getRoles();

  Future<RoleModel> getRole(String name);

  Future<RoleModel> enableRole(String name, bool enableOrDisable);
}

class RoleRemoteDataSourceImpl implements RoleRemoteDataSource {
  final http.Client client;
  RoleRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RoleModel>> getRoles() async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      final List<RoleModel> searchUsers = fakeRoles
          /*.where((o) => (o.name.contains(filter) ||
              o.name.contains(filter) ||
              o.username.contains(filter) ||
              o.email.contains(filter)))
          .skip(((pageNumber.toInt() - 1) * pageSize))
          .take(pageSize)*/
          .toList();

      return Future.value(searchUsers);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RoleModel> getRole(String name) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      final role = fakeRoles.singleWhere((o) => (o.name == name));
      return Future.value(role);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RoleModel> enableRole(String name, bool enableOrDisable) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      RoleModel roleModel =
          fakeRoles.singleWhere((element) => element.name == name);

      RoleModel newRoleModel = RoleModel(
          name: roleModel.name,
          enabled: enableOrDisable);

      int index = fakeRoles.indexWhere((element) => element.name == name);
      fakeRoles[index] = newRoleModel;

      return newRoleModel;
    } else {
      throw ServerException();
    }
  }
}
