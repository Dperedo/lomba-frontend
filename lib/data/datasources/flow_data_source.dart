import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:lomba_frontend/domain/entities/flows/textcontent.dart';
import '../../core/constants.dart';
import '../../core/exceptions.dart';
import '../../core/failures.dart';
import '../../core/model_container.dart';
import '../../domain/entities/flows/post.dart';
import '../../domain/entities/flows/postitem.dart';
import '../../domain/entities/flows/stage.dart';
import '../../domain/entities/flows/total.dart';
import '../../domain/entities/flows/track.dart';
import '../../domain/entities/flows/vote.dart';
import '../models/flow/post_model.dart';
import 'local_data_source.dart';

abstract class FlowRemoteDataSource {
  Future<PostModel> addTextPost(String orgaId, String userId, TextContent text,
      String title, String flowId, bool isDraft);
  Future<ModelContainer<PostModel>> getPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize,
      Map<String, dynamic> params,
      String boxpage);

  Future<ModelContainer<Vote>> votePublication(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String postId,
      int voteValue);
}

class FlowRemoteDataSourceImpl implements FlowRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  FlowRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<PostModel> addTextPost(String orgaId, String userId, TextContent text,
      String title, String flowId, bool isDraft) async {
    final Map<String, dynamic> newTextPost = {
      'userId': userId,
      'orgaId': orgaId,
      'textContent': text,
      'title': title,
      'flowId': flowId,
      'isdraft': false
    };
    final url = Uri.parse('${UrlBackend.base}/api/v1/post');
    final session = await localDataSource.getSavedSession();

    http.Response resp =
        await client.post(url, body: json.encode(newTextPost), headers: {
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
              updated: e['updated'] != null
                  ? DateTime.parse(e['updated'].toString())
                  : null,
              deleted: e['deleted'] != null
                  ? DateTime.parse(e['deleted'].toString())
                  : null,
              expires: e['expires'] != null
                  ? DateTime.parse(e['expires'].toString())
                  : null))
          .toList();

      List<PostItem> listPostItems = [];
      List<Total> listTotals = [];
      List<Track> listTracks = [];

      return Future.value(PostModel(
        id: item['id'].toString(),
        enabled: item['enabled'].toString().toLowerCase() == 'true',
        builtIn: item['builtIn'].toString().toLowerCase() == 'true',
        title: item['titles'].toString(),
        orgaId: item['orgaId'].toString(),
        userId: item['userId'].toString(),
        flowId: item['flowId'].toString(),
        stageId: item['stageId'].toString(),
        created: DateTime.parse(item['created'].toString()),
        updated: item['updated'] != null
            ? DateTime.parse(item['updated'].toString())
            : null,
        deleted: item['deleted'] != null
            ? DateTime.parse(item['deleted'].toString())
            : null,
        expires: item['expires'] != null
            ? DateTime.parse(item['expires'].toString())
            : null,
        stages: listStage,
        postitems: listPostItems,
        totals: listTotals,
        tracks: listTracks,
      ));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ModelContainer<PostModel>> getPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize,
      Map<String, dynamic> params,
      String boxpage) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/post/box?orgaId=$orgaId&userId=$userId&flowId=$flowId&stageId=$stageId&searchText=$searchText&fieldsOrder=$fieldsOrder&pageIndex=$pageIndex&pageSize=$pageSize&params=$params&boxpage=$boxpage');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<PostModel> listPostModel = [];

      //iteración por cada item
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
                updated: e['updated'] != null
                    ? DateTime.parse(e['updated'].toString())
                    : null,
                deleted: e['deleted'] != null
                    ? DateTime.parse(e['deleted'].toString())
                    : null,
                expires: e['expires'] != null
                    ? DateTime.parse(e['expires'].toString())
                    : null))
            .toList();

        //completar con lógica
        List<PostItem> listPostItems = (item['postitems']as List)
          .map((e)=> PostItem(
            content: e['content'], 
            type: e['type'],
            order: int.parse(e['order'].toString()), 
            format: e['format'].toString(),
            builtIn: e['builtIn'].toString().toLowerCase() == 'true', 
            created: DateTime.parse(e['created'].toString()),
            deleted: e['deleted'] != null
                    ? DateTime.parse(e['deleted'].toString())
                    : null, 
            expires: e['expires'] != null
                    ? DateTime.parse(e['expires'].toString())
                    : null, 
            updated: e['updated'] != null
                    ? DateTime.parse(e['updated'].toString())
                    : null
          ))
        .toList();


        List<Total> listTotals = (item['totals']as List)
        .map((e) => Total(
          flowId: e['flowId'].toString(), 
          stageId: e['stageId'].toString(), 
          totalcount: int.parse(e['totalcount'].toString()),
          totalnegative: int.parse(e['totalnegative'].toString()),
          totalpositive: int.parse(e['totalpositive'].toString()),
        ))
        .toList();


        List<Track> listTracks = (item['tracks']as List)
        .map((e)=>Track(
          userId: e['userId'].toString(), 
          flowId: e['flowId'].toString(), 
          stageId: e['stageId'].toString(), 
          change: e['change'].toString(), 
          created: DateTime.parse(e['created'].toString()), 
          deleted: e['deleted'] != null
                    ? DateTime.parse(e['deleted'].toString())
                    : null,
          expires: e['expires'] != null
                    ? DateTime.parse(e['expires'].toString())
                    : null,
          updated: e['updated'] != null
                    ? DateTime.parse(e['updated'].toString())
                    : null
        ))
        .toList();

        //se agrega uno a uno cada PostModel nuevo.
        listPostModel.add(PostModel(
          id: item['id'].toString(),
          enabled: item['enabled'].toString().toLowerCase() == 'true',
          builtIn: item['builtIn'].toString().toLowerCase() == 'true',
          title: item['titles'].toString(),
          orgaId: item['orgaId'].toString(),
          userId: item['userId'].toString(),
          flowId: item['flowId'].toString(),
          stageId: item['stageId'].toString(),
          created: DateTime.parse(item['created'].toString()),
          updated: item['updated'] != null
              ? DateTime.parse(item['updated'].toString())
              : null,
          deleted: item['deleted'] != null
              ? DateTime.parse(item['deleted'].toString())
              : null,
          expires: item['expires'] != null
              ? DateTime.parse(item['expires'].toString())
              : null,
          stages: listStage,
          postitems: listPostItems,
          totals: listTotals,
          tracks: listTracks,
        ));
      }

      return Future.value(ModelContainer<PostModel>(
          listPostModel,
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
  Future<ModelContainer<Post>> getVotedPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize,
      int voteState)async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/post/box?orgaId=$orgaId&userId=$userId&flowId=$flowId&stageId=$stageId&searchText=$searchText&fieldsOrder=$fieldsOrder&pageIndex=$pageIndex&pageSize=$pageSize&voteState=$voteState');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<PostModel> listPostModel = [];

      //iteración por cada item
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
                updated: e['updated'] != null
                    ? DateTime.parse(e['updated'].toString())
                    : null,
                deleted: e['deleted'] != null
                    ? DateTime.parse(e['deleted'].toString())
                    : null,
                expires: e['expires'] != null
                    ? DateTime.parse(e['expires'].toString())
                    : null))
            .toList();

        //completar con lógica
        List<PostItem> listPostItems = (item['postitems']as List)
          .map((e)=> PostItem(
            content: e['content'], 
            type: e['type'],
            order: int.parse(e['order'].toString()), 
            format: e['format'].toString(),
            builtIn: e['builtIn'].toString().toLowerCase() == 'true', 
            created: DateTime.parse(e['created'].toString()),
            deleted: e['deleted'] != null
                    ? DateTime.parse(e['deleted'].toString())
                    : null, 
            expires: e['expires'] != null
                    ? DateTime.parse(e['expires'].toString())
                    : null, 
            updated: e['updated'] != null
                    ? DateTime.parse(e['updated'].toString())
                    : null
          ))
        .toList();


        List<Total> listTotals = (item['totals']as List)
        .map((e) => Total(
          flowId: e['flowId'].toString(), 
          stageId: e['stageId'].toString(), 
          totalcount: int.parse(e['totalcount'].toString()),
          totalnegative: int.parse(e['totalnegative'].toString()),
          totalpositive: int.parse(e['totalpositive'].toString()),
        ))
        .toList();


        List<Track> listTracks = (item['tracks']as List)
        .map((e)=>Track(
          userId: e['userId'].toString(), 
          flowId: e['flowId'].toString(), 
          stageId: e['stageId'].toString(), 
          change: e['change'].toString(), 
          created: DateTime.parse(e['created'].toString()), 
          deleted: e['deleted'] != null
                    ? DateTime.parse(e['deleted'].toString())
                    : null,
          expires: e['expires'] != null
                    ? DateTime.parse(e['expires'].toString())
                    : null,
          updated: e['updated'] != null
                    ? DateTime.parse(e['updated'].toString())
                    : null
        ))
        .toList();

        //se agrega uno a uno cada PostModel nuevo.
        listPostModel.add(PostModel(
          id: item['id'].toString(),
          enabled: item['enabled'].toString().toLowerCase() == 'true',
          builtIn: item['builtIn'].toString().toLowerCase() == 'true',
          title: item['titles'].toString(),
          orgaId: item['orgaId'].toString(),
          userId: item['userId'].toString(),
          flowId: item['flowId'].toString(),
          stageId: item['stageId'].toString(),
          created: DateTime.parse(item['created'].toString()),
          updated: item['updated'] != null
              ? DateTime.parse(item['updated'].toString())
              : null,
          deleted: item['deleted'] != null
              ? DateTime.parse(item['deleted'].toString())
              : null,
          expires: item['expires'] != null
              ? DateTime.parse(item['expires'].toString())
              : null,
          stages: listStage,
          postitems: listPostItems,
          totals: listTotals,
          tracks: listTracks,
        ));
      }

      return Future.value(ModelContainer<PostModel>(
          listPostModel,
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
  Future<ModelContainer<Vote>> votePublication(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String postId,
      int voteValue)async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/post/box?orgaId=$orgaId&userId=$userId&flowId=$flowId&stageId=$stageId&voteValue=$voteValue');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<Vote> listVote = [];

      //iteración por cada item
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
                updated: e['updated'] != null
                    ? DateTime.parse(e['updated'].toString())
                    : null,
                deleted: e['deleted'] != null
                    ? DateTime.parse(e['deleted'].toString())
                    : null,
                expires: e['expires'] != null
                    ? DateTime.parse(e['expires'].toString())
                    : null))
            .toList();

        //completar con lógica
        List<PostItem> listPostItems = (item['postitems']as List)
          .map((e)=> PostItem(
            content: e['content'], 
            type: e['type'],
            order: int.parse(e['order'].toString()), 
            format: e['format'].toString(),
            builtIn: e['builtIn'].toString().toLowerCase() == 'true', 
            created: DateTime.parse(e['created'].toString()),
            deleted: e['deleted'] != null
                    ? DateTime.parse(e['deleted'].toString())
                    : null, 
            expires: e['expires'] != null
                    ? DateTime.parse(e['expires'].toString())
                    : null, 
            updated: e['updated'] != null
                    ? DateTime.parse(e['updated'].toString())
                    : null
          ))
        .toList();


        List<Total> listTotals = (item['totals']as List)
        .map((e) => Total(
          flowId: e['flowId'].toString(), 
          stageId: e['stageId'].toString(), 
          totalcount: int.parse(e['totalcount'].toString()),
          totalnegative: int.parse(e['totalnegative'].toString()),
          totalpositive: int.parse(e['totalpositive'].toString()),
        ))
        .toList();


        List<Track> listTracks = (item['tracks']as List)
        .map((e)=>Track(
          userId: e['userId'].toString(), 
          flowId: e['flowId'].toString(), 
          stageId: e['stageId'].toString(), 
          change: e['change'].toString(), 
          created: DateTime.parse(e['created'].toString()), 
          deleted: e['deleted'] != null
                    ? DateTime.parse(e['deleted'].toString())
                    : null,
          expires: e['expires'] != null
                    ? DateTime.parse(e['expires'].toString())
                    : null,
          updated: e['updated'] != null
                    ? DateTime.parse(e['updated'].toString())
                    : null
        ))
        .toList();

        //se agrega uno a uno cada PostModel nuevo.
        listVote.add(Vote(
          userId: item['userId'].toString(),
          flowId: item['flowId'].toString(),
          stageId: item['stageId'].toString(),
          created: DateTime.parse(item['created'].toString()),
          updated: item['updated'] != null
              ? DateTime.parse(item['updated'].toString())
              : null,
          deleted: item['deleted'] != null
              ? DateTime.parse(item['deleted'].toString())
              : null,
          expires: item['expires'] != null
              ? DateTime.parse(item['expires'].toString())
              : null,
          value: int.parse(item['totalcount'].toString()),
        ));
      }

      return Future.value(ModelContainer<Vote>(
          listVote,
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
}
