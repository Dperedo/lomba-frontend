import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lomba_frontend/core/data/datasources/local_data_source.dart';
import 'package:lomba_frontend/core/fakedata.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/exceptions.dart';
import '../models/orga_model.dart';
import '../models/orgauser_model.dart';

//Interfaz del DataSource de organizaciones (remoto) hacia el backend
abstract class OrgaRemoteDataSource {
  Future<List<OrgaModel>> getOrgas(
      String filter, String fieldOrder, double pageNumber, int pageSize);
  Future<OrgaModel> getOrga(String orgaId);

  Future<List<OrgaUserModel>> getOrgaUsers(String orgaId);

  Future<List<OrgaUserModel>> getOrgaUser(String orgaId, String userId);

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

///Implementación de [OrgaRemoteDataSource] con todos sus métodos.
class OrgaRemoteDataSourceImpl implements OrgaRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  OrgaRemoteDataSourceImpl({required this.client, required this.localDataSource});

  ///Entrega una lista de organizaciones según los filtros
  ///
  ///[filter] es de tipo texto y si no hay filtro debe venir vacío.
  ///[fieldOrder] es el nombre del campo por el cual filtrar ascendentemente
  ///[pageNumber] es el número de página de la lista de organizaciones
  ///[pageSize] es el tamaño de cada página. Sólo se traerá una página.
  @override
  Future<List<OrgaModel>> getOrgas(
      String filter, String fieldOrder, double pageNumber, int pageSize) async {
    //parsea URL
    final url = Uri.parse('${UrlBackend.base}/api/v1/orga/');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<OrgaModel> orgas = [];

      for (var item in resObj['data']['items']) {
        orgas.add(OrgaModel(
            id: item["id"].toString(),
            name: item["name"].toString(),
            code: item["code"].toString(),
            enabled: item["enabled"].toString().toLowerCase() == 'true',
            builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
      }

      return Future.value(orgas);
    } else {
      throw ServerException();
    }
  }

  ///Entrega una organización a partir del Id de la organización
  @override
  Future<OrgaModel> getOrga(String orgaId) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/orga/$orgaId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];
      return Future.value(OrgaModel(
          id: item["id"].toString(),
          name: item["name"].toString(),
          code: item["code"].toString(),
          enabled: item["enabled"].toString().toLowerCase() == 'true',
          builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
    } else {
      throw ServerException();
    }
  }

  ///Entrega una lista de OrgaUsers a partir del Id de la organización
  @override
  Future<List<OrgaUserModel>> getOrgaUsers(String orgaId) async {
    //parsea URL
    final url = Uri.parse('${UrlBackend.base}/api/v1/orgauser/byorga/$orgaId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<OrgaUserModel> orgaUsers = [];

      for (var item in resObj['data']['items']) {
        List<String> roleslist = [];
        for(var r in item['roles']){
            roleslist.add(r['name']);
        }
        orgaUsers.add(OrgaUserModel(
            userId: item["userId"].toString(),
            orgaId: item["orgaId"].toString(),
            roles: roleslist,
            enabled: item["enabled"].toString().toLowerCase() == 'true',
            builtIn: item["builtin"].toString().toLowerCase() == 'true'));
      }

      return Future.value(orgaUsers);
    } else {
      throw ServerException();
    }
  }

  ///Entrega una organización a partir del Id de la organización
  @override
  Future<List<OrgaUserModel>> getOrgaUser(String orgaId, String userId) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/orgauser/$orgaId/$userId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];

      List<OrgaUserModel> orgaUsers = [];

      for (var item in resObj['data']['items']) {
        List<String> roleslist = [];
        for(var r in item['roles']){
            roleslist.add(r['name']);
        }
        orgaUsers.add(OrgaUserModel(
            userId: item["userId"].toString(),
            orgaId: item["orgaId"].toString(),
            roles: roleslist,
            enabled: item["enabled"].toString().toLowerCase() == 'true',
            builtIn: item["builtin"].toString().toLowerCase() == 'true'));
      }

      return Future.value(orgaUsers);
    } else {
      throw ServerException();
    }
  }

  ///Agrega un Orga recibiendo un OrgaModel
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

  ///Agrega una relación OrgaUser a partir de un OrgaUserModel
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

  ///Elimina una organización a partir del Id de organización
  @override
  Future<bool> deleteOrga(String orgaId) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/orga/$orgaId');
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

  ///Elimina una relación OrgaUser a partir de los Id [orgaId] y [userId]
  @override
  Future<bool> deleteOrgaUser(String orgaId, String userId) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/orgauser/$orgaId/$userId');
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

  ///Habilita o deshabilita una organización a partir del Id de organización
  ///
  ///En el parámetro [enableOrDisable] se especifica el nuevo valor de
  ///habilitación
  @override
  Future<bool> enableOrga(String orgaId, bool enableOrDisable) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/orga/enable/$orgaId?enable=${enableOrDisable.toString()}');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.put(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      return Future.value(
          resObj['data']['items'][0]['value'].toString().toLowerCase()== 'true');
    } else {
      throw ServerException();
    }
  }

  ///Habilita o deshabilita un OrgaUser a partir del Id de organización y userId
  ///
  ///En el parámetro [enableOrDisable] se especifica el nuevo valor de
  ///habilitación
  @override
  Future<bool> enableOrgaUser(
      String orgaId, String userId, bool enableOrDisable) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/orgauser/enable/$orgaId/$userId?enable=${enableOrDisable.toString()}');
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

      /*OrgaUserModel orgaUserModel = fakeListOrgaUsers.singleWhere(
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

      return newOrgaUserModel;*/
    } else {
      throw ServerException();
    }
  }

  ///Actualiza una organización con el Id de organización y un OrgaModel
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

  ///Actualiza un OrgaUser con Id organización, userio y un OrgaUserModel
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
