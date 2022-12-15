import 'package:lomba_frontend/core/fakedata.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/exceptions.dart';

import 'package:http/http.dart' as http;

import '../models/orga_model.dart';
import '../models/orgauser_model.dart';

abstract class OrgaRemoteDataSource {
  Future<List<OrgaModel>> getOrgas(
      String filter, String fieldOrder, double pageNumber, int pageSize);
  Future<OrgaModel> getOrga(String orgaId);
  Future<List<OrgaUserModel>> getOrgaUsers(String orgaId);
  Future<OrgaModel> addOrga(OrgaModel orga);
  Future<OrgaUserModel> addOrgaUser(OrgaUserModel orgaUser);
  Future<bool> deleteOrga(String orgaId);
  Future<bool> deleteOrgaUser(String orgaId, String userId);
  Future<bool> enableOrga(String orgaId, bool enableOrDisable);
  Future<bool> enableOrgaUser(
      String orgaId, String userId, bool enableOrDisable);
  Future<OrgaModel> updateOrga(String orgaId, OrgaModel orga);
  Future<OrgaUserModel> updateOrgaUser(
      String orgaId, String userId, OrgaUserModel orgaUser);
}

class OrgaRemoteDataSourceImpl implements OrgaRemoteDataSource {
  final http.Client client;
  OrgaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<OrgaModel>> getOrgas(
      String filter, String fieldOrder, double pageNumber, int pageSize) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      final List<OrgaModel> searchOrgas = fakeListOrgas
          .where((o) => (o.id.contains(filter) ||
              o.name.contains(filter) ||
              o.code.contains(filter)))
          .skip(((pageNumber.toInt() - 1) * pageSize))
          .take(pageSize)
          .toList();

      return Future.value(searchOrgas);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OrgaModel> getOrga(String orgaId) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      final orga = fakeListOrgas.singleWhere((o) => (o.id == orgaId));
      return Future.value(orga);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<OrgaUserModel>> getOrgaUsers(String orgaId) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      final List<OrgaUserModel> searchOrgaUsers =
          fakeListOrgaUsers.where((o) => (o.orgaId == orgaId)).toList();

      return Future.value(searchOrgaUsers);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OrgaModel> addOrga(OrgaModel orga) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      fakeListOrgas.add(orga);
      return orga;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OrgaUserModel> addOrgaUser(OrgaUserModel orgaUser) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      fakeListOrgaUsers.add(orgaUser);
      return orgaUser;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> deleteOrga(String orgaId) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      fakeListOrgas.removeWhere((element) => element.id == orgaId);
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> deleteOrgaUser(String orgaId, String userId) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      fakeListOrgaUsers.removeWhere(
          (element) => element.orgaId == orgaId && element.userId == userId);
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> enableOrga(String orgaId, bool enableOrDisable) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      OrgaModel orgaModel =
          fakeListOrgas.singleWhere((element) => element.id == orgaId);

      OrgaModel newOrgaModel = OrgaModel(
          id: orgaModel.id,
          name: orgaModel.name,
          code: orgaModel.code,
          enabled: enableOrDisable,
          builtIn: orgaModel.builtIn);

      int index = fakeListOrgas.indexWhere((element) => element.id == orgaId);
      fakeListOrgas[index] = newOrgaModel;

      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> enableOrgaUser(
      String orgaId, String userId, bool enableOrDisable) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      OrgaUserModel orgaUserModel = fakeListOrgaUsers.singleWhere(
          (element) => element.orgaId == orgaId && element.userId == userId);

      OrgaUserModel newOrgaUserModel = OrgaUserModel(
          orgaId: orgaUserModel.orgaId,
          userId: orgaUserModel.userId,
          roles: orgaUserModel.roles,
          enabled: enableOrDisable,
          builtIn: orgaUserModel.builtIn);

      int index = fakeListOrgaUsers.indexWhere(
          (element) => element.orgaId == orgaId && element.userId == userId);
      fakeListOrgaUsers[index] = newOrgaUserModel;

      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OrgaModel> updateOrga(String orgaId, OrgaModel orga) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      int index = fakeListOrgas.indexWhere((element) => element.id == orgaId);
      fakeListOrgas[index] = orga;

      return orga;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OrgaUserModel> updateOrgaUser(
      String orgaId, String userId, OrgaUserModel orgaUser) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      int index = fakeListOrgaUsers.indexWhere(
          (element) => element.orgaId == orgaId && element.userId == userId);
      fakeListOrgaUsers[index] = orgaUser;

      return orgaUser;
    } else {
      throw ServerException();
    }
  }
}
