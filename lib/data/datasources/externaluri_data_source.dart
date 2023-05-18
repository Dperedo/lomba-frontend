import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lomba_frontend/domain/entities/storage/host.dart';

import '../../core/constants.dart';
import '../../core/exceptions.dart';
import '../models/storage/externaluri_model.dart';
import 'local_data_source.dart';

abstract class ExternalUriRemoteDataSource {
  Future<ExternalUriModel> postExternalUri(
      String userId, String uri);
  Future<ExternalUriModel> getExternalUriById(
      String uriId);
  Future<ExternalUriModel> getExternalUriByUri(
      String uri);
}

class ExternalUriRemoteDataSourceImpl implements ExternalUriRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  ExternalUriRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<ExternalUriModel> postExternalUri(
      String userId, String uri) async {
    final Map<String, dynamic> registerData = {
      'userId': userId,
      'uri': uri
      };
    final url = Uri.parse('${UrlBackend.base}/api/v1/externaluri/');
    final session = await localDataSource.getSavedSession();

    http.Response resp =
        await client.post(url, body: json.encode(registerData), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];

      List<String> nameslist = [];
        /*for (var r in item['hosts']['names']) {
          nameslist.add(r);
        }*/

      List<Host> listHosts = item['hosts'] != null
        ? (item['hosts'] as List)
            .map((e) => Host(
                  id: e['id'].toString(),
                  host: e['host'].toString(),
                  names: nameslist,
                ))
            .toList()
        : [];

      return Future.value(ExternalUriModel(
          id: item["id"].toString(),
          userId: item["userId"].toString(),
          uri: item["uri"].toString(),
          path: item["path"].toString(),
          host: item["host"].toString(),
          hosts: listHosts,
          sourceName: item["sourceName"].toString(),
          title: item["title"].toString(),
          shortUrl: item["shortUrl"].toString(),
          description: item["description"].toString(),
          type: item["type"].toString(),
          httpstatus: int.parse(item["httpstatus"].toString()),
          lastchecked:
              item["updated"] == null ? null : DateTime.parse(item["lastchecked"]),
          ));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ExternalUriModel> getExternalUriById(
      String uriId) async {
    
    final url = Uri.parse('${UrlBackend.base}/api/v1/externaluri/$uriId');
    final session = await localDataSource.getSavedSession();

    http.Response resp =
        await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];

      List<String> nameslist = [];
        /*for (var r in item['hosts']['names']) {
          nameslist.add(r);
        }*/

      List<Host> listHosts = item['hosts'] != null
        ? (item['hosts'] as List)
            .map((e) => Host(
                  id: e['id'].toString(),
                  host: e['host'].toString(),
                  names: nameslist,
                ))
            .toList()
        : [];

      return Future.value(ExternalUriModel(
          id: item["id"].toString(),
          userId: item["userId"].toString(),
          uri: item["uri"].toString(),
          path: item["path"].toString(),
          host: item["host"].toString(),
          hosts: listHosts,
          sourceName: item["sourceName"].toString(),
          title: item["title"].toString(),
          shortUrl: item["shortUrl"].toString(),
          description: item["description"].toString(),
          type: item["type"].toString(),
          httpstatus: int.parse(item["httpstatus"].toString()),
          lastchecked:
              item["updated"] == null ? null : DateTime.parse(item["lastchecked"]),
          ));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ExternalUriModel> getExternalUriByUri(
      String uri) async {
    
    final url = Uri.parse('${UrlBackend.base}/api/v1/externaluri/$uri');
    final session = await localDataSource.getSavedSession();

    http.Response resp =
        await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];

      List<String> nameslist = [];
        /*for (var r in item['hosts']['names']) {
          nameslist.add(r);
        }*/

      List<Host> listHosts = item['hosts'] != null
        ? (item['hosts'] as List)
            .map((e) => Host(
                  id: e['id'].toString(),
                  host: e['host'].toString(),
                  names: nameslist,
                ))
            .toList()
        : [];

      return Future.value(ExternalUriModel(
          id: item["id"].toString(),
          userId: item["userId"].toString(),
          uri: item["uri"].toString(),
          path: item["path"].toString(),
          host: item["host"].toString(),
          hosts: listHosts,
          sourceName: item["sourceName"].toString(),
          title: item["title"].toString(),
          shortUrl: item["shortUrl"].toString(),
          description: item["description"].toString(),
          type: item["type"].toString(),
          httpstatus: int.parse(item["httpstatus"].toString()),
          lastchecked:
              item["updated"] == null ? null : DateTime.parse(item["lastchecked"]),
          ));
    } else {
      throw ServerException();
    }
  }
}