import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/workflow/comment_model.dart';
import 'local_data_source.dart';

import '../../../core/constants.dart';
import '../../../core/exceptions.dart';

abstract class CommentRemoteDataSource {
  Future<CommentModel> postComment(String userId, String postId, String text);

  Future<List<CommentModel>> getCommentsPost(String postId, String sort, int pageIndex, int pageSize, Map<String, dynamic> params,);

  Future<bool> deleteComment(String userId, String postId, String commentId);
}

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  CommentRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<CommentModel> postComment(String userId, String postId, String text,) async {
    
    final Map<String, dynamic> commentData = 
    {
      'userId': userId,
      'postId': postId,
      'text': text,
    };

    final url = Uri.parse('${UrlBackend.base}/api/v1/comment/');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.post(url, body: json.encode(commentData), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];

      return Future.value(CommentModel(
            id: item["id"].toString(),
            userId: item["userId"].toString(),
            postId: item["postId"].toString(),
            text: item["text"].toString(),
            enabled: item["enabled"].toString().toLowerCase() == 'true',
            ));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> deleteComment(String userId, String postId, String commentId) async {
    
    final Map<String, dynamic> commentData = 
    {
      'userId': userId,
      'postId': postId,
      'commentId': commentId,
    };

    final url = Uri.parse('${UrlBackend.base}/api/v1/comment/');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.delete(url, body: json.encode(commentData), headers: {
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
  Future<List<CommentModel>> getCommentsPost(String postId, String sort, int pageIndex, int pageSize, Map<String, dynamic> params,) async {

    final url = Uri.parse('${UrlBackend.base}/api/v1/comment/');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<CommentModel> comments = [];

      for (var item in resObj['data']['items']) {
        comments.add(CommentModel(
            id: item["id"].toString(),
            userId: item["userId"].toString(),
            postId: item["postId"].toString(),
            text: item["text"].toString(),
            enabled: item["enabled"].toString().toLowerCase() == 'true',
            ));
      }

      return Future.value(comments);

    } else {
      throw ServerException();
    }
  }
}
