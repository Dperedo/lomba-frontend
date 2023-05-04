import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/workflow/bookmark_model.dart';
import 'local_data_source.dart';

import '../../../core/constants.dart';
import '../../../core/exceptions.dart';

abstract class BookmarkRemoteDataSource {
  Future<BookmarkModel> postBookmark(String userId, String postId, String markType, bool giveOrTakeAway);
}

class BookmarkRemoteDataSourceImpl implements BookmarkRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  BookmarkRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<BookmarkModel> postBookmark(String userId, String postId, String markType, bool giveOrTakeAway) async {
    
    final Map<String, dynamic> markTypeData = 
    {
      'userId': userId,
      'postId': postId,
      'markType': markType,
      'giveOrTakeAway': giveOrTakeAway,
    };

    final url = Uri.parse('${UrlBackend.base}/api/v1/bookmark/');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.post(url, body: json.encode(markTypeData), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];

      return Future.value(BookmarkModel(
            userId: item["userId"].toString(),
            postId: item["postId"].toString(),
            markType: item["markType"].toString(),
            enabled: item["enabled"].toString().toLowerCase() == 'true',
            ));
    } else {
      throw ServerException();
    }
  }
}
