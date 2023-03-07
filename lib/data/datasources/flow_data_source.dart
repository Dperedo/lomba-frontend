
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants.dart';
import '../../core/exceptions.dart';
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
        List<String> stageslist = [];
        for (var r in item['stages']) {
          stageslist.add(r['name']);
        }
        flows.add(FlowModel(
          id: item["id"].toString(),
          name: item["name"].toString(),
          enabled: item["enabled"].toString().toLowerCase() == 'true',
          builtIn: item["builtIn"].toString().toLowerCase() == 'true',
          stages: stageslist,
          created: item['created'].toString(),
          updated: item['updated'].toString(),
          deleted: item['deleted'].toString(),
          expires: item['expires'].toString()
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

      List<String> stageslist = [];
      for (var r in item['stages']) {
        stageslist.add(r['name']);
      }
      return Future.value(FlowModel(
        id: item["id"].toString(),
        name: item["name"].toString(),
        enabled: item["enabled"].toString().toLowerCase() == 'true',
        builtIn: item["builtIn"].toString().toLowerCase() == 'true',
        stages: stageslist,
        created: item['created'].toString(),
        updated: item['updated'].toString(),
        deleted: item['deleted'].toString(),
        expires: item['expires'].toString()
      ));
      
    } else {
      throw ServerException();
    }
  }
}
