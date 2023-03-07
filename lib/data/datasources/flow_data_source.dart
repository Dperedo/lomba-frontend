
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants.dart';
import '../../core/exceptions.dart';
import '../../domain/entities/workflow/stage.dart';
import '../models/workflow/flow_model.dart';
import 'local_data_source.dart';

abstract class FlowRemoteDataSource {
  Future<List<FlowModel>> getFlows();
  Future<FlowModel> getFlow(String flowId);
}

class FlowRemoteDataSourceImpl implements FlowRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  FlowRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<List<FlowModel>> getFlows() async {
    //parsea URL
    final url = Uri.parse('${UrlBackend.base}/api/v1/post/flow/');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<FlowModel> flows = [];

      for (var item in resObj['data']['items']) {
        List<Stage> listStage = (item['stages'] as List)
          .map((e) => Stage(
              id: e['id'].toString(),
              name: e['name'].toString(),
              order: int.parse(e['order'].toString()),
              queryOut: e['queryOut'],
              enabled: e['enabled'].toString().toLowerCase() == 'true',
              builtIn: e['builtIn'].toString().toLowerCase() == 'true',
              created: DateTime.parse(e['created'].toString()),
              updated: e['updated'] != null? DateTime.parse(e['updated'].toString()): null,
              deleted: e['deleted'] != null? DateTime.parse(e['deleted'].toString()): null,
              expires: e['expires'] != null? DateTime.parse(e['expires'].toString()): null))
          .toList();

        flows.add(FlowModel(
          id: item["id"].toString(),
          name: item["name"].toString(),
          enabled: item["enabled"].toString().toLowerCase() == 'true',
          builtIn: item["builtIn"].toString().toLowerCase() == 'true',
          stages: listStage,
          created: DateTime.parse(item['created'].toString()),
        updated: item['updated'] != null? DateTime.parse(item['updated'].toString()): null,
        deleted: item['deleted'] != null? DateTime.parse(item['deleted'].toString()): null,
        expires: item['expires'] != null? DateTime.parse(item['expires'].toString()): null
        ));
      }

      return Future.value(flows);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<FlowModel> getFlow(String flowId) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/post/flow/$flowId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];

      List<Stage> listStage = (item['stages'] as List)
        .map((e) => Stage(
            id: e['id'].toString(),
            name: e['name'].toString(),
            order: int.parse(e['order'].toString()),
            queryOut: e['queryOut'],
            enabled: e['enabled'].toString().toLowerCase() == 'true',
            builtIn: e['builtIn'].toString().toLowerCase() == 'true',
            created: DateTime.parse(e['created'].toString()),
            updated: e['updated'] != null? DateTime.parse(e['updated'].toString()): null,
            deleted: e['deleted'] != null? DateTime.parse(e['deleted'].toString()): null,
            expires: e['expires'] != null? DateTime.parse(e['expires'].toString()): null))
        .toList();

      return Future.value(FlowModel(
        id: item["id"].toString(),
        name: item["name"].toString(),
        enabled: item["enabled"].toString().toLowerCase() == 'true',
        builtIn: item["builtIn"].toString().toLowerCase() == 'true',
        stages: listStage,
        created: DateTime.parse(item['created'].toString()),
        updated: item['updated'] != null? DateTime.parse(item['updated'].toString()): null,
        deleted: item['deleted'] != null? DateTime.parse(item['deleted'].toString()): null,
        expires: item['expires'] != null? DateTime.parse(item['expires'].toString()): null
      ));
      
    } else {
      throw ServerException();
    }
  }
}
