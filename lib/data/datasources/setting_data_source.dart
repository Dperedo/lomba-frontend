import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants.dart';
import '../../core/exceptions.dart';
import '../models/setting_model.dart';
import 'local_data_source.dart';

abstract class SettingRemoteDataSource {
  Future<List<SettingModel>> getSettingSuper();
  Future<List<SettingModel>> getSettingAdmin(String orgaId);
  Future<bool> updatedSettingSuper(String id,String value);
  Future<bool> updatedSettingAdmin(String id,String value,String orgaId);
}

class SettingRemoteDataSourceImpl implements SettingRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  SettingRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<List<SettingModel>> getSettingSuper() async {
    //parsea URL
    final url = Uri.parse('${UrlBackend.base}/api/v1/setting/');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<SettingModel> setting = [];

      for (var item in resObj['data']['items']) {
        setting.add(SettingModel(
        id: item["id"].toString(),
        code: item["code"].toString(),
        value: item["value"].toString(),
        orgaId: item['orgaId'] != null? item["orgaId"].toString(): null,
        builtIn: item["builtIn"].toString().toLowerCase() == 'true',
        created: DateTime.parse(item['created'].toString()),
        updated: item['updated'] != null? DateTime.parse(item['updated'].toString()): null,
        ));
      }

      return Future.value(setting);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SettingModel>> getSettingAdmin(String orgaId) async {
    //parsea URL
    final url = Uri.parse('${UrlBackend.base}/api/v1/setting/byorga/$orgaId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<SettingModel> setting = [];

      for (var item in resObj['data']['items']) {
        setting.add(SettingModel(
        id: item["id"].toString(),
        code: item["code"].toString(),
        value: item["value"].toString(),
        orgaId: item['orgaId'] != null? item["orgaId"].toString(): null,
        builtIn: item["builtIn"].toString().toLowerCase() == 'true',
        created: DateTime.parse(item['created'].toString()),
        updated: item['updated'] != null? DateTime.parse(item['updated'].toString()): null,
        ));
      }

      return Future.value(setting);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updatedSettingSuper(String id,String value) async {
    final Map<String, dynamic> newSetting = {
      'id': id,
      'value': value,
      };
    final url = Uri.parse('${UrlBackend.base}/api/v1/setting/');
    final session = await localDataSource.getSavedSession();

    http.Response resp =
        await client.put(url, body: json.encode(newSetting), headers: {
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

  @override
  Future<bool> updatedSettingAdmin(String id,String value,String orgaId) async {
    final Map<String, dynamic> newSetting = {
      'id': id,
      'value': value,
      };
    final url = Uri.parse('${UrlBackend.base}/api/v1/setting/byorga/$orgaId');
    final session = await localDataSource.getSavedSession();

    http.Response resp =
        await client.put(url, body: json.encode(newSetting), headers: {
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