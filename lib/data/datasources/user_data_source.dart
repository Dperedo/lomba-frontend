import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lomba_frontend/data/datasources/local_data_source.dart';
import 'package:lomba_frontend/core/fakedata.dart';

import '../../../core/constants.dart';
import '../../../core/exceptions.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers(String orgaId, String filter,
      String fieldOrder, double pageNumber, int pageSize);
  Future<UserModel> getUser(String userId);

  Future<UserModel> addUser(UserModel user);

  Future<bool> deleteUser(String userId);

  Future<bool> enableUser(String userId, bool enableOrDisable);

  Future<UserModel> updateUser(String userId, UserModel user);

  Future<UserModel?> existsUser(String userId, String username, String email);

  Future<List<UserModel>> getUsersNotInOrga(
      String orgaId, List<dynamic> order, int pageNumber, int pageSize);

  Future<bool> updateUserPassword(String userId, String password);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  UserRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<List<UserModel>> getUsers(String orgaId, String filter,
      String fieldOrder, double pageNumber, int pageSize) async {
    //parsea URL

    final url = Uri.parse('${UrlBackend.base}/api/v1/user/byorga/$orgaId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<UserModel> users = [];

      for (var item in resObj['data']['items']) {
        users.add(UserModel(
            id: item["id"].toString(),
            name: item["name"].toString(),
            username: item["username"].toString(),
            email: item["email"].toString(),
            enabled: item["enabled"].toString().toLowerCase() == 'true',
            builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
      }

      return Future.value(users);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUser(String userId) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/user/$userId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];
      return Future.value(UserModel(
          id: item["id"].toString(),
          name: item["name"].toString(),
          username: item["username"].toString(),
          email: item["email"].toString(),
          enabled: item["enabled"].toString().toLowerCase() == 'true',
          builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> addUser(UserModel user) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      fakeListUsers.add(user);
      return user;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> deleteUser(String userId) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/user/$userId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.delete(url, headers: {
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
  Future<bool> enableUser(String userId, bool enableOrDisable) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/user/enable/$userId?enable=${enableOrDisable.toString()}');
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

  @override
  Future<UserModel> updateUser(String userId, UserModel user) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/user/$userId');
    final session = await localDataSource.getSavedSession();

    http.Response resp =
        await client.put(url, body: json.encode(user), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];
      return Future.value(UserModel(
          id: item["id"].toString(),
          name: item["name"].toString(),
          username: item["username"].toString(),
          email: item["email"].toString(),
          enabled: item["enabled"].toString().toLowerCase() == 'true',
          builtIn: item["builtin"].toString().toLowerCase() == 'true'));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel?> existsUser(
      String userId, String username, String email) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/user/if/exists/?userId=${userId.toString()}&username=${username.toString()}&email=${email.toString()}');
    final session = await localDataSource.getSavedSession();
    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));
    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);
      if (resObj['data']['currentItemCount'] > 0) {
        final item = resObj['data']['items'][0];
        return Future.value(UserModel(
            id: item["id"].toString(),
            name: item["name"].toString(),
            username: item["username"].toString(),
            email: item["email"].toString(),
            enabled: item["enabled"].toString().toLowerCase() == 'true',
            builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
      }
      return Future.value(null);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<UserModel>> getUsersNotInOrga(
      String orgaId, List<dynamic> order, int pageNumber, int pageSize) async {
    //parsea URL
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/user/notinorga/$orgaId?sort=${json.encode(order)}&pageIndex=$pageNumber&itemsPerPage=$pageSize');
    final session = await localDataSource.getSavedSession();
    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));
    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);
      List<UserModel> users = [];
      for (var item in resObj['data']['items']) {
        users.add(UserModel(
            id: item["id"].toString(),
            name: item["name"].toString(),
            username: item["username"].toString(),
            email: item["email"].toString(),
            enabled: item["enabled"].toString().toLowerCase() == 'true',
            builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
      }
      return Future.value(users);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateUserPassword(String userId, String password) async {
    final Map<String, dynamic> passData = {'password': password};
    final url = Uri.parse('${UrlBackend.base}/api/v1/password/$userId');
    final session = await localDataSource.getSavedSession();

    http.Response resp =
        await client.put(url, body: json.encode(passData), headers: {
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
