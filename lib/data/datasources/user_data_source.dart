import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lomba_frontend/data/datasources/local_data_source.dart';
import 'package:lomba_frontend/core/fakedata.dart';

import '../../../core/constants.dart';
import '../../../core/exceptions.dart';
import '../../core/model_container.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<ModelContainer<UserModel>> getUsers(String searchText, String orgaId,
      List<dynamic> order, int pageIndex, int pageSize);
  Future<UserModel> getUser(String userId);

  Future<UserModel> addUser(UserModel user);

  Future<bool> deleteUser(String userId);

  Future<bool> enableUser(String userId, bool enableOrDisable);

  Future<UserModel> updateUser(String userId, UserModel user);

  Future<UserModel> updateProfile(String userId, UserModel user);

  Future<UserModel?> existsUser(String userId, String username, String email);

  Future<UserModel?> existsProfile(
      String userId, String username, String email);

  Future<ModelContainer<UserModel>> getUsersNotInOrga(String searchText,
      String orgaId, List<dynamic> order, int pageIndex, int pageSize);

  Future<bool> updateUserPassword(String userId, String password);

  Future<bool> updateProfilePassword(String userId, String password);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  UserRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<ModelContainer<UserModel>> getUsers(String searchText, String orgaId,
      List<dynamic> order, int pageIndex, int pageSize) async {
    //parsea URL

    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/user/byorga/$orgaId?sort=${json.encode(order)}&searchtext=$searchText&pageindex=$pageIndex&pagesize=$pageSize');
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
            builtIn: item["builtIn"].toString().toLowerCase() == 'true',
            pictureUrl: item["pictureUrl"] != null ? item['pictureUrl'].toString() : null,
            pictureCloudFileId: item["pictureCloudFileId"] != null ? item['pictureCloudFileId'].toString() : null,
            pictureThumbnailUrl: item["pictureThumbnailUrl"] != null ? item['pictureThumbnailUrl'].toString() : null,
            pictureThumbnailCloudFileId: item["pictureThumbnailCloudFileId"] != null ? item['pictureThumbnailCloudFileId'].toString() : null,));
      }

      return Future.value(ModelContainer<UserModel>(
          users,
          int.parse(resObj['data']['currentItemCount'].toString()),
          resObj['data']['itemsPerPage'] != null
              ? int.parse(resObj['data']['itemsPerPage'].toString())
              : null,
          resObj['data']['startIndex'] != null
              ? int.parse(resObj['data']['startIndex'].toString())
              : null,
          resObj['data']['totalItems'] != null
              ? int.parse(resObj['data']['totalItems'].toString())
              : null,
          resObj['data']['pageIndex'] != null
              ? int.parse(resObj['data']['pageIndex'].toString())
              : null,
          resObj['data']['totalPages'] != null
              ? int.parse(resObj['data']['totalPages'].toString())
              : null,
          resObj['data']['kind'].toString()));
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
          builtIn: item["builtIn"].toString().toLowerCase() == 'true',
          pictureUrl: item["pictureUrl"] != null ? item['pictureUrl'].toString() : null,
          pictureCloudFileId: item["pictureCloudFileId"] != null ? item['pictureCloudFileId'].toString() : null,
          pictureThumbnailUrl: item["pictureThumbnailUrl"] != null ? item['pictureThumbnailUrl'].toString() : null,
          pictureThumbnailCloudFileId: item["pictureThumbnailCloudFileId"] != null ? item['pictureThumbnailCloudFileId'].toString() : null,));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> addUser(UserModel user) async {
    final response = await client.get(Uri.parse(UrlBackend.base));

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
          builtIn: item["builtin"].toString().toLowerCase() == 'true',
          pictureUrl: item["pictureUrl"] != null ? item['pictureUrl'].toString() : null,
          pictureCloudFileId: item["pictureCloudFileId"] != null ? item['pictureCloudFileId'].toString() : null,
          pictureThumbnailUrl: item["pictureThumbnailUrl"] != null ? item['pictureThumbnailUrl'].toString() : null,
          pictureThumbnailCloudFileId: item["pictureThumbnailCloudFileId"] != null ? item['pictureThumbnailCloudFileId'].toString() : null,));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> updateProfile(String userId, UserModel user) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/user/profile/$userId');
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
          builtIn: item["builtin"].toString().toLowerCase() == 'true',
          pictureUrl: item["pictureUrl"] != null ? item['pictureUrl'].toString() : null,
          pictureCloudFileId: item["pictureCloudFileId"] != null ? item['pictureCloudFileId'].toString() : null,
          pictureThumbnailUrl: item["pictureThumbnailUrl"] != null ? item['pictureThumbnailUrl'].toString() : null,
          pictureThumbnailCloudFileId: item["pictureThumbnailCloudFileId"] != null ? item['pictureThumbnailCloudFileId'].toString() : null,));
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
            builtIn: item["builtIn"].toString().toLowerCase() == 'true',
            pictureUrl: item["pictureUrl"] != null ? item['pictureUrl'].toString() : null,
            pictureCloudFileId: item["pictureCloudFileId"] != null ? item['pictureCloudFileId'].toString() : null,
            pictureThumbnailUrl: item["pictureThumbnailUrl"] != null ? item['pictureThumbnailUrl'].toString() : null,
            pictureThumbnailCloudFileId: item["pictureThumbnailCloudFileId"] != null ? item['pictureThumbnailCloudFileId'].toString() : null,));
      }
      return Future.value(null);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel?> existsProfile(
      String userId, String username, String email) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/user/if/exists/profile/?userId=${userId.toString()}&username=${username.toString()}&email=${email.toString()}');
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
            builtIn: item["builtIn"].toString().toLowerCase() == 'true',
            pictureUrl: item["pictureUrl"] != null ? item['pictureUrl'].toString() : null,
            pictureCloudFileId: item["pictureCloudFileId"] != null ? item['pictureCloudFileId'].toString() : null,
            pictureThumbnailUrl: item["pictureThumbnailUrl"] != null ? item['pictureThumbnailUrl'].toString() : null,
            pictureThumbnailCloudFileId: item["pictureThumbnailCloudFileId"] != null ? item['pictureThumbnailCloudFileId'].toString() : null,));
      }
      return Future.value(null);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ModelContainer<UserModel>> getUsersNotInOrga(String searchText,
      String orgaId, List<dynamic> order, int pageIndex, int pageSize) async {
    //parsea URL
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/user/notinorga/$orgaId?sort=${json.encode(order)}&searchtext=$searchText&pageindex=$pageIndex&pagesize=$pageSize');
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
            builtIn: item["builtIn"].toString().toLowerCase() == 'true',
            pictureUrl: item["pictureUrl"] != null ? item['pictureUrl'].toString() : null,
            pictureCloudFileId: item["pictureCloudFileId"] != null ? item['pictureCloudFileId'].toString() : null,
            pictureThumbnailUrl: item["pictureThumbnailUrl"] != null ? item['pictureThumbnailUrl'].toString() : null,
            pictureThumbnailCloudFileId: item["pictureThumbnailCloudFileId"] != null ? item['pictureThumbnailCloudFileId'].toString() : null,));
      }
      return Future.value(ModelContainer<UserModel>(
          users,
          int.parse(resObj['data']['currentItemCount'].toString()),
          resObj['data']['itemsPerPage'] != null
              ? int.parse(resObj['data']['itemsPerPage'].toString())
              : null,
          resObj['data']['startIndex'] != null
              ? int.parse(resObj['data']['startIndex'].toString())
              : null,
          resObj['data']['totalItems'] != null
              ? int.parse(resObj['data']['totalItems'].toString())
              : null,
          resObj['data']['pageIndex'] != null
              ? int.parse(resObj['data']['pageIndex'].toString())
              : null,
          resObj['data']['totalPages'] != null
              ? int.parse(resObj['data']['totalPages'].toString())
              : null,
          resObj['data']['kind'].toString()));
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

  @override
  Future<bool> updateProfilePassword(String userId, String password) async {
    final Map<String, dynamic> passData = {'password': password};
    final url = Uri.parse('${UrlBackend.base}/api/v1/password/profile/$userId');
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
