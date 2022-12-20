import 'package:lomba_frontend/core/fakedata.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/exceptions.dart';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers(String orgaId, String filter,
      String fieldOrder, double pageNumber, int pageSize);
  Future<UserModel> getUser(String userId);

  Future<UserModel> addUser(UserModel user);

  Future<bool> deleteUser(String userId);

  Future<UserModel> enableUser(String userId, bool enableOrDisable);

  Future<UserModel> updateUser(String userId, UserModel user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getUsers(String orgaId, String filter,
      String fieldOrder, double pageNumber, int pageSize) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      final List<UserModel> searchUsers = fakeListUsers
          .where((o) => (o.id.contains(filter) ||
              o.name.contains(filter) ||
              o.username.contains(filter) ||
              o.email.contains(filter)))
          .skip(((pageNumber.toInt() - 1) * pageSize))
          .take(pageSize)
          .toList();

      return Future.value(searchUsers);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUser(String userId) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      final user = fakeListUsers.singleWhere((o) => (o.id == userId));
      return Future.value(user);
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
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      fakeListUsers.removeWhere((element) => element.id == userId);
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> enableUser(String userId, bool enableOrDisable) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      UserModel userModel =
          fakeListUsers.singleWhere((element) => element.id == userId);

      UserModel newUserModel = UserModel(
          id: userModel.id,
          name: userModel.name,
          username: userModel.username,
          email: userModel.email,
          enabled: enableOrDisable,
          builtIn: userModel.builtIn);

      int index = fakeListUsers.indexWhere((element) => element.id == userId);
      fakeListUsers[index] = newUserModel;

      return newUserModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> updateUser(String userId, UserModel user) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      int index = fakeListUsers.indexWhere((element) => element.id == userId);

      fakeListUsers[index] = user;

      return user;
    } else {
      throw ServerException();
    }
  }
}
