import 'dart:convert';

import 'package:http/http.dart' as http;
import 'local_data_source.dart';

import '../../../core/constants.dart';
import '../../../core/exceptions.dart';
import '../models/role_model.dart';

abstract class RoleRemoteDataSource {
  Future<List<RoleModel>> getRoles();

  Future<RoleModel> getRole(String name);

  Future<bool> enableRole(String name, bool enableOrDisable);
}

class RoleRemoteDataSourceImpl implements RoleRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  RoleRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<List<RoleModel>> getRoles() async {
    //parsea URL
    final url = Uri.parse('${UrlBackend.base}/api/v1/role/');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<RoleModel> roles = [];

      for (var item in resObj['data']['items']) {
        roles.add(RoleModel(
            name: item["name"].toString(),
            enabled: item["enabled"].toString().toLowerCase() == 'true'));
      }

      return Future.value(roles);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RoleModel> getRole(String name) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/role/$name');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];
      return Future.value(RoleModel(
          name: item["name"].toString(),
          enabled: item["enabled"].toString().toLowerCase() == 'true'));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> enableRole(String name, bool enableOrDisable) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/role/enable/$name?enable=${enableOrDisable.toString()}');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.put(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      return Future.value(
          resObj['data']['items'][0].toString().toLowerCase() == 'true');
    } else {
      throw ServerException();
    }
  }
}
