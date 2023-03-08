
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants.dart';
import '../../core/exceptions.dart';
import '../models/workflow/stage_model.dart';
import 'local_data_source.dart';

abstract class StageRemoteDataSource {
  Future<List<StageModel>> getStages();
  Future<StageModel> getStage(String stageId);
}

class StageRemoteDataSourceImpl implements StageRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  StageRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<List<StageModel>> getStages() async {
    //parsea URL
    final url = Uri.parse('${UrlBackend.base}/api/v1/stage/');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<StageModel> stages = [];

      for (var item in resObj['data']['items']) {
        stages.add(StageModel(
        id: item["id"].toString(),
        name: item["name"].toString(),
        order: int.parse(item['order'].toString()),
        queryOut: item['queryOut'] != null? item["queryOut"].toString(): null,//  item["queryOut"].toString(),
        enabled: item["enabled"].toString().toLowerCase() == 'true',
        builtIn: item["builtIn"].toString().toLowerCase() == 'true',
        created: DateTime.parse(item['created'].toString()),
        updated: item['updated'] != null? DateTime.parse(item['updated'].toString()): null,
        deleted: item['deleted'] != null? DateTime.parse(item['deleted'].toString()): null,
        expires: item['expires'] != null? DateTime.parse(item['expires'].toString()): null
        ));
      }

      return Future.value(stages);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<StageModel> getStage(String stageId) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/stage/$stageId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];

      return Future.value(StageModel(
        id: item["id"].toString(),
        name: item["name"].toString(),
        order: int.parse(item['order'].toString()),
        queryOut: item['queryOut'] != null? item["queryOut"].toString(): null,
        enabled: item["enabled"].toString().toLowerCase() == 'true',
        builtIn: item["builtIn"].toString().toLowerCase() == 'true',
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
