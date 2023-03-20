import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lomba_frontend/domain/entities/workflow/textcontent.dart';

import '../../core/constants.dart';
import '../../core/exceptions.dart';
import '../../core/model_container.dart';
import '../../domain/entities/workflow/postitem.dart';
import '../../domain/entities/workflow/stage.dart';
import '../../domain/entities/workflow/total.dart';
import '../../domain/entities/workflow/track.dart';
import '../../domain/entities/workflow/vote.dart';
import '../models/workflow/post_model.dart';
import 'local_data_source.dart';

abstract class PostRemoteDataSource {
  Future<PostModel> addTextPost(String orgaId, String userId, TextContent text,
      String title, String flowId, bool isDraft);
  Future<PostModel> updatePost(
      String postId, String userId, TextContent text, String title);
  Future<PostModel> deletePost(String postId, String userId);
  Future<PostModel> getPost(String postId);
  Future<ModelContainer<PostModel>> getPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      List<dynamic> order,
      int pageIndex,
      int pageSize,
      Map<String, dynamic> params,
      String boxpage);
  Future<ModelContainer<PostModel>> getAdminViewPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      List<dynamic> order,
      int pageIndex,
      int pageSize,
      Map<String, dynamic> params);
  Future<ModelContainer<Vote>> votePublication(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String postId,
      int voteValue);
  Future<PostModel> changeStagePost(
      String postId,
      String flowId,
      String stageId,);
  Future<bool> enablePost(
      String postId,
      bool enableOrDisable);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  PostRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<PostModel> addTextPost(String orgaId, String userId, TextContent text,
      String title, String flowId, bool isDraft) async {
    final Map<String, dynamic> newTextPost = {
      'userId': userId,
      'orgaId': orgaId,
      'flowId': flowId,
      'title': title,
      'textContent': {'text': text.text},
      'isdraft': isDraft
    };
    final session = await localDataSource.getSavedSession();
    final url = Uri.parse('${UrlBackend.base}/api/v1/post');

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

      //completar con lógica
      List<PostItem> listPostItems = (item['postitems'] as List)
          .map((e) => PostItem(
              content: TextContent(text: e['content']['text'].toString()),
              type: e['type'].toString(),
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
                  : null))
          .toList();

      List<Total> listTotals = (item['totals'] as List)
          .map((e) => Total(
                flowId: e['flowId'].toString(),
                stageId: e['stageId'].toString(),
                totalcount: int.parse(e['totalcount'].toString()),
                totalnegative: int.parse(e['totalnegative'].toString()),
                totalpositive: int.parse(e['totalpositive'].toString()),
              ))
          .toList();

      List<Track> listTracks = (item['tracks'] as List)
          .map((e) => Track(
              name: e['name'].toString(),
              description: e['description'].toString(),
              userId: e['userId'].toString(),
              flowId: e['flowId'].toString(),
              stageIdOld: e['stageIdOld'].toString(),
              stageIdNew: e['stageIdNew'].toString(),
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
                  : null))
          .toList();

      List<Vote> listVotes = item['votes'] != null
          ? (item['votes'] as List)
              .map((e) => Vote(
                    userId: e['userId'].toString(),
                    flowId: e['flowId'].toString(),
                    stageId: e['stageId'].toString(),
                    created: DateTime.parse(e['created'].toString()),
                    updated: e['updated'] != null
                        ? DateTime.parse(e['updated'].toString())
                        : null,
                    deleted: e['deleted'] != null
                        ? DateTime.parse(e['deleted'].toString())
                        : null,
                    expires: e['expires'] != null
                        ? DateTime.parse(e['expires'].toString())
                        : null,
                    value: int.parse(e['value'].toString()),
                  ))
              .toList()
          : [];

      return Future.value(PostModel(
        id: item['id'].toString(),
        enabled: item['enabled'].toString().toLowerCase() == 'true',
        builtIn: item['builtIn'].toString().toLowerCase() == 'true',
        title: item['title'].toString(),
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
        votes: listVotes,
      ));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> getPost(
      String postId,) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/post/$postId');
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
        List<PostItem> listPostItems = (item['postitems'] as List)
            .map((e) => PostItem(
                content: TextContent(text: e['content']['text'].toString()),
                type: e['type'].toString(),
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
                    : null))
            .toList();

        List<Total> listTotals = (item['totals'] as List)
            .map((e) => Total(
                  flowId: e['flowId'].toString(),
                  stageId: e['stageId'].toString(),
                  totalcount: int.parse(e['totalcount'].toString()),
                  totalnegative: int.parse(e['totalnegative'].toString()),
                  totalpositive: int.parse(e['totalpositive'].toString()),
                ))
            .toList();

        List<Track> listTracks = (item['tracks'] as List)
            .map((e) => Track(
                name: e['name'].toString(),
                description: e['description'].toString(),
                userId: e['userId'].toString(),
                flowId: e['flowId'].toString(),
                stageIdOld: e['stageIdOld'].toString(),
                stageIdNew: e['stageIdNew'].toString(),
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
                    : null))
            .toList();

        List<Vote> listVotes = item['votes'] != null
            ? (item['votes'] as List)
                .map((e) => Vote(
                      userId: e['userId'].toString(),
                      flowId: e['flowId'].toString(),
                      stageId: e['stageId'].toString(),
                      created: DateTime.parse(e['created'].toString()),
                      updated: e['updated'] != null
                          ? DateTime.parse(e['updated'].toString())
                          : null,
                      deleted: e['deleted'] != null
                          ? DateTime.parse(e['deleted'].toString())
                          : null,
                      expires: e['expires'] != null
                          ? DateTime.parse(e['expires'].toString())
                          : null,
                      value: int.parse(e['value'].toString()),
                    ))
                .toList()
            : [];

        //se agrega uno a uno cada PostModel nuevo.
        listPostModel.add(PostModel(
          id: item['id'].toString(),
          enabled: item['enabled'].toString().toLowerCase() == 'true',
          builtIn: item['builtIn'].toString().toLowerCase() == 'true',
          title: item['title'].toString(),
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
          votes: listVotes,
        ));
      }

      return Future.value(listPostModel[0]);
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
      List<dynamic> order,
      int pageIndex,
      int pageSize,
      Map<String, dynamic> params,
      String boxpage) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/post/box?orgaId=$orgaId&userId=$userId&flowId=$flowId&stageId=$stageId&searchtext=$searchText&sort=${json.encode(order)}&pageindex=$pageIndex&pagesize=$pageSize&paramvars=${json.encode(params)}&boxpage=$boxpage');
    //final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      //"Authorization": "Bearer ${session.token}",
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
        List<PostItem> listPostItems = (item['postitems'] as List)
            .map((e) => PostItem(
                content: TextContent(text: e['content']['text'].toString()),
                type: e['type'].toString(),
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
                    : null))
            .toList();

        List<Total> listTotals = (item['totals'] as List)
            .map((e) => Total(
                  flowId: e['flowId'].toString(),
                  stageId: e['stageId'].toString(),
                  totalcount: int.parse(e['totalcount'].toString()),
                  totalnegative: int.parse(e['totalnegative'].toString()),
                  totalpositive: int.parse(e['totalpositive'].toString()),
                ))
            .toList();

        List<Track> listTracks = (item['tracks'] as List)
            .map((e) => Track(
                name: e['name'].toString(),
                description: e['description'].toString(),
                userId: e['userId'].toString(),
                flowId: e['flowId'].toString(),
                stageIdOld: e['stageIdOld'].toString(),
                stageIdNew: e['stageIdNew'].toString(),
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
                    : null))
            .toList();

        List<Vote> listVotes = item['votes'] != null
            ? (item['votes'] as List)
                .map((e) => Vote(
                      userId: e['userId'].toString(),
                      flowId: e['flowId'].toString(),
                      stageId: e['stageId'].toString(),
                      created: DateTime.parse(e['created'].toString()),
                      updated: e['updated'] != null
                          ? DateTime.parse(e['updated'].toString())
                          : null,
                      deleted: e['deleted'] != null
                          ? DateTime.parse(e['deleted'].toString())
                          : null,
                      expires: e['expires'] != null
                          ? DateTime.parse(e['expires'].toString())
                          : null,
                      value: int.parse(e['value'].toString()),
                    ))
                .toList()
            : [];

        //se agrega uno a uno cada PostModel nuevo.
        listPostModel.add(PostModel(
          id: item['id'].toString(),
          enabled: item['enabled'].toString().toLowerCase() == 'true',
          builtIn: item['builtIn'].toString().toLowerCase() == 'true',
          title: item['title'].toString(),
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
          votes: listVotes,
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

/*
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
      int voteState) async {
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
        List<PostItem> listPostItems = (item['postitems'] as List)
            .map((e) => PostItem(
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
                    : null))
            .toList();

        List<Total> listTotals = (item['totals'] as List)
            .map((e) => Total(
                  flowId: e['flowId'].toString(),
                  stageId: e['stageId'].toString(),
                  totalcount: int.parse(e['totalcount'].toString()),
                  totalnegative: int.parse(e['totalnegative'].toString()),
                  totalpositive: int.parse(e['totalpositive'].toString()),
                ))
            .toList();

        List<Track> listTracks = (item['tracks'] as List)
            .map((e) => Track(
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
                    : null))
            .toList();

        List<Vote> listVotes = item['votes'] != null
            ? (item['votes'] as List)
                .map((e) => Vote(
                      userId: e['userId'].toString(),
                      flowId: e['flowId'].toString(),
                      stageId: e['stageId'].toString(),
                      created: DateTime.parse(e['created'].toString()),
                      updated: e['updated'] != null
                          ? DateTime.parse(e['updated'].toString())
                          : null,
                      deleted: e['deleted'] != null
                          ? DateTime.parse(e['deleted'].toString())
                          : null,
                      expires: e['expires'] != null
                          ? DateTime.parse(e['expires'].toString())
                          : null,
                      value: int.parse(e['value'].toString()),
                    ))
                .toList()
            : [];

        //se agrega uno a uno cada PostModel nuevo.
        listPostModel.add(PostModel(
          id: item['id'].toString(),
          enabled: item['enabled'].toString().toLowerCase() == 'true',
          builtIn: item['builtIn'].toString().toLowerCase() == 'true',
          title: item['title'].toString(),
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
          votes: listVotes,
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
*/
  @override
  Future<ModelContainer<Vote>> votePublication(String orgaId, String userId,
      String flowId, String stageId, String postId, int voteValue) async {
    final Map<String, dynamic> newVote = {
      'orgaId': orgaId,
      'userId': userId,
      'flowId': flowId,
      'stageId': stageId,
      'postId': postId,
      'voteValue': voteValue
    };

    final url = Uri.parse('${UrlBackend.base}/api/v1/post/vote');
    final session = await localDataSource.getSavedSession();

    http.Response resp =
        await client.post(url, body: json.encode(newVote), headers: {
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
        List<PostItem> listPostItems = (item['postitems'] as List)
            .map((e) => PostItem(
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
                    : null))
            .toList();

        List<Total> listTotals = (item['totals'] as List)
            .map((e) => Total(
                  flowId: e['flowId'].toString(),
                  stageId: e['stageId'].toString(),
                  totalcount: int.parse(e['totalcount'].toString()),
                  totalnegative: int.parse(e['totalnegative'].toString()),
                  totalpositive: int.parse(e['totalpositive'].toString()),
                ))
            .toList();

        List<Track> listTracks = (item['tracks'] as List)
            .map((e) => Track(
                name: e['name'].toString(),
                description: e['description'].toString(),
                userId: e['userId'].toString(),
                flowId: e['flowId'].toString(),
                stageIdOld: e['stageIdOld'].toString(),
                stageIdNew: e['stageIdNew'].toString(),
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
                    : null))
            .toList();

        //se agrega uno a uno cada PostModel nuevo.
        List<Vote> listVotes = item['votes'] != null
            ? (item['votes'] as List)
                .map((e) => Vote(
                      userId: e['userId'].toString(),
                      flowId: e['flowId'].toString(),
                      stageId: e['stageId'].toString(),
                      created: DateTime.parse(e['created'].toString()),
                      updated: e['updated'] != null
                          ? DateTime.parse(e['updated'].toString())
                          : null,
                      deleted: e['deleted'] != null
                          ? DateTime.parse(e['deleted'].toString())
                          : null,
                      expires: e['expires'] != null
                          ? DateTime.parse(e['expires'].toString())
                          : null,
                      value: int.parse(e['value'].toString()),
                    ))
                .toList()
            : [];
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

  @override
  Future<PostModel> updatePost(
      String postId, String userId, TextContent text, String title) async {
    final Map<String, dynamic> editPost = {
      'userId': userId,
      'postId': postId,
      'title': title,
      'textContent': {'text': text.text}
    };
    final session = await localDataSource.getSavedSession();
    final url = Uri.parse('${UrlBackend.base}/api/v1/post');

    http.Response resp =
        await client.put(url, body: json.encode(editPost), headers: {
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

      //completar con lógica
      List<PostItem> listPostItems = (item['postitems'] as List)
          .map((e) => PostItem(
              content: TextContent(text: e['content']['text'].toString()),
              type: e['type'].toString(),
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
                  : null))
          .toList();

      List<Total> listTotals = (item['totals'] as List)
          .map((e) => Total(
                flowId: e['flowId'].toString(),
                stageId: e['stageId'].toString(),
                totalcount: int.parse(e['totalcount'].toString()),
                totalnegative: int.parse(e['totalnegative'].toString()),
                totalpositive: int.parse(e['totalpositive'].toString()),
              ))
          .toList();

      List<Track> listTracks = (item['tracks'] as List)
          .map((e) => Track(
              name: e['name'].toString(),
              description: e['description'].toString(),
              userId: e['userId'].toString(),
              flowId: e['flowId'].toString(),
              stageIdOld: e['stageIdOld'].toString(),
              stageIdNew: e['stageIdNew'].toString(),
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
                  : null))
          .toList();

      List<Vote> listVotes = item['votes'] != null
          ? (item['votes'] as List)
              .map((e) => Vote(
                    userId: e['userId'].toString(),
                    flowId: e['flowId'].toString(),
                    stageId: e['stageId'].toString(),
                    created: DateTime.parse(e['created'].toString()),
                    updated: e['updated'] != null
                        ? DateTime.parse(e['updated'].toString())
                        : null,
                    deleted: e['deleted'] != null
                        ? DateTime.parse(e['deleted'].toString())
                        : null,
                    expires: e['expires'] != null
                        ? DateTime.parse(e['expires'].toString())
                        : null,
                    value: int.parse(e['value'].toString()),
                  ))
              .toList()
          : [];

      return Future.value(PostModel(
        id: item['id'].toString(),
        enabled: item['enabled'].toString().toLowerCase() == 'true',
        builtIn: item['builtIn'].toString().toLowerCase() == 'true',
        title: item['title'].toString(),
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
        votes: listVotes,
      ));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> deletePost(String postId, String userId) async {
    final Map<String, dynamic> deletePost = {
      'userId': userId,
      'postId': postId,
    };
    final session = await localDataSource.getSavedSession();
    final url = Uri.parse('${UrlBackend.base}/api/v1/post');

    http.Response resp =
        await client.delete(url, body: json.encode(deletePost), headers: {
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

      //completar con lógica
      List<PostItem> listPostItems = (item['postitems'] as List)
          .map((e) => PostItem(
              content: TextContent(text: e['content']['text'].toString()),
              type: e['type'].toString(),
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
                  : null))
          .toList();

      List<Total> listTotals = (item['totals'] as List)
          .map((e) => Total(
                flowId: e['flowId'].toString(),
                stageId: e['stageId'].toString(),
                totalcount: int.parse(e['totalcount'].toString()),
                totalnegative: int.parse(e['totalnegative'].toString()),
                totalpositive: int.parse(e['totalpositive'].toString()),
              ))
          .toList();

      List<Track> listTracks = (item['tracks'] as List)
          .map((e) => Track(
              name: e['name'].toString(),
              description: e['description'].toString(),
              userId: e['userId'].toString(),
              flowId: e['flowId'].toString(),
              stageIdOld: e['stageIdOld'].toString(),
              stageIdNew: e['stageIdNew'].toString(),
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
                  : null))
          .toList();

      List<Vote> listVotes = item['votes'] != null
          ? (item['votes'] as List)
              .map((e) => Vote(
                    userId: e['userId'].toString(),
                    flowId: e['flowId'].toString(),
                    stageId: e['stageId'].toString(),
                    created: DateTime.parse(e['created'].toString()),
                    updated: e['updated'] != null
                        ? DateTime.parse(e['updated'].toString())
                        : null,
                    deleted: e['deleted'] != null
                        ? DateTime.parse(e['deleted'].toString())
                        : null,
                    expires: e['expires'] != null
                        ? DateTime.parse(e['expires'].toString())
                        : null,
                    value: int.parse(e['value'].toString()),
                  ))
              .toList()
          : [];

      return Future.value(PostModel(
        id: item['id'].toString(),
        enabled: item['enabled'].toString().toLowerCase() == 'true',
        builtIn: item['builtIn'].toString().toLowerCase() == 'true',
        title: item['title'].toString(),
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
        votes: listVotes,
      ));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ModelContainer<PostModel>> getAdminViewPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      List<dynamic> order,
      int pageIndex,
      int pageSize,
      Map<String, dynamic> params) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/post/admin?orgaId=$orgaId&userId=$userId&flowId=$flowId&stageId=$stageId&searchtext=$searchText&sort=${json.encode(order)}&pageindex=$pageIndex&pagesize=$pageSize&paramvars=${json.encode(params)}');
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
        List<PostItem> listPostItems = (item['postitems'] as List)
            .map((e) => PostItem(
                content: TextContent(text: e['content']['text'].toString()),
                type: e['type'].toString(),
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
                    : null))
            .toList();

        List<Total> listTotals = (item['totals'] as List)
            .map((e) => Total(
                  flowId: e['flowId'].toString(),
                  stageId: e['stageId'].toString(),
                  totalcount: int.parse(e['totalcount'].toString()),
                  totalnegative: int.parse(e['totalnegative'].toString()),
                  totalpositive: int.parse(e['totalpositive'].toString()),
                ))
            .toList();

        List<Track> listTracks = (item['tracks'] as List)
            .map((e) => Track(
                name: e['name'].toString(),
                description: e['description'].toString(),
                userId: e['userId'].toString(),
                flowId: e['flowId'].toString(),
                stageIdOld: e['stageIdOld'].toString(),
                stageIdNew: e['stageIdNew'].toString(),
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
                    : null))
            .toList();

        List<Vote> listVotes = item['votes'] != null
            ? (item['votes'] as List)
                .map((e) => Vote(
                      userId: e['userId'].toString(),
                      flowId: e['flowId'].toString(),
                      stageId: e['stageId'].toString(),
                      created: DateTime.parse(e['created'].toString()),
                      updated: e['updated'] != null
                          ? DateTime.parse(e['updated'].toString())
                          : null,
                      deleted: e['deleted'] != null
                          ? DateTime.parse(e['deleted'].toString())
                          : null,
                      expires: e['expires'] != null
                          ? DateTime.parse(e['expires'].toString())
                          : null,
                      value: int.parse(e['value'].toString()),
                    ))
                .toList()
            : [];

        //se agrega uno a uno cada PostModel nuevo.
        listPostModel.add(PostModel(
          id: item['id'].toString(),
          enabled: item['enabled'].toString().toLowerCase() == 'true',
          builtIn: item['builtIn'].toString().toLowerCase() == 'true',
          title: item['title'].toString(),
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
          votes: listVotes,
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
  Future<PostModel> changeStagePost(
      String postId,
      String flowId,
      String stageId) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/post/stage/$postId?flowId=$flowId&stageId=$stageId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.put(url, headers: {
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
        List<PostItem> listPostItems = (item['postitems'] as List)
            .map((e) => PostItem(
                content: TextContent(text: e['content']['text'].toString()),
                type: e['type'].toString(),
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
                    : null))
            .toList();

        List<Total> listTotals = (item['totals'] as List)
            .map((e) => Total(
                  flowId: e['flowId'].toString(),
                  stageId: e['stageId'].toString(),
                  totalcount: int.parse(e['totalcount'].toString()),
                  totalnegative: int.parse(e['totalnegative'].toString()),
                  totalpositive: int.parse(e['totalpositive'].toString()),
                ))
            .toList();

        List<Track> listTracks = (item['tracks'] as List)
            .map((e) => Track(
                name: e['name'].toString(),
                description: e['description'].toString(),
                userId: e['userId'].toString(),
                flowId: e['flowId'].toString(),
                stageIdOld: e['stageIdOld'].toString(),
                stageIdNew: e['stageIdNew'].toString(),
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
                    : null))
            .toList();

        List<Vote> listVotes = item['votes'] != null
            ? (item['votes'] as List)
                .map((e) => Vote(
                      userId: e['userId'].toString(),
                      flowId: e['flowId'].toString(),
                      stageId: e['stageId'].toString(),
                      created: DateTime.parse(e['created'].toString()),
                      updated: e['updated'] != null
                          ? DateTime.parse(e['updated'].toString())
                          : null,
                      deleted: e['deleted'] != null
                          ? DateTime.parse(e['deleted'].toString())
                          : null,
                      expires: e['expires'] != null
                          ? DateTime.parse(e['expires'].toString())
                          : null,
                      value: int.parse(e['value'].toString()),
                    ))
                .toList()
            : [];

        //se agrega uno a uno cada PostModel nuevo.
        listPostModel.add(PostModel(
          id: item['id'].toString(),
          enabled: item['enabled'].toString().toLowerCase() == 'true',
          builtIn: item['builtIn'].toString().toLowerCase() == 'true',
          title: item['title'].toString(),
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
          votes: listVotes,
        ));
      }

      return Future.value(listPostModel[0]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> enablePost(
      String postId,
      bool enableOrDisable) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/post/enable/$postId?enable=${enableOrDisable.toString()}');
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
}