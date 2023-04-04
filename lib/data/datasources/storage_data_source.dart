import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:lomba_frontend/domain/entities/storage/cloudfile.dart';
import '../../core/constants.dart';
import '../../core/exceptions.dart';
import '../models/storage/cloudfile_model.dart';
import 'local_data_source.dart';

abstract class StorageRemoteDataSource {
  Future<CloudFileModel> uploadFile(
      Uint8List file, String cloudFileId);
  Future<CloudFileModel> registerCloudFile(String userId, String orgaId);
  Future<CloudFileModel> getCloudFile(String cloudFileId);
}

class StorageRemoteDataSourceImpl implements StorageRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  StorageRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<CloudFileModel> uploadFile(
      Uint8List file, String cloudFileId) async {
    final session = await localDataSource.getSavedSession();
    final url = Uri.parse('${UrlBackend.base}/api/v1/storage');

    //busca respuesta desde el servidor para la autenticación
    /*
    final fileEncoded = base64Encode(file);
    final Map<String, dynamic> dataToPost = {
      'fileEncoded': fileEncoded,
    };
    */

    var request = http.MultipartRequest('PUT', url);

    request.files
        .add(http.MultipartFile.fromBytes("file", file, filename: cloudFileId+".jpg"));
    request.fields.addAll({'cloudFileId': cloudFileId});

    request.headers.addAll({
      "Accept": "*/*",
      "Content-Type": "multipart/form-data;",
      "Content-Length": request.contentLength.toString(),
      "Authorization": "Bearer ${session.token}",
    });
    http.StreamedResponse resp =
        await request.send().timeout(const Duration(seconds: 300));

    final respFromStream = await http.Response.fromStream(resp);

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(respFromStream.body);

      final item = resObj['data']['items'][0];
      return Future.value(CloudFileModel(
          id: item["id"].toString(),
          name: item["name"].toString(),
          path: item["path"].toString(),
          host: item["host"].toString(),
          url: item["url"].toString(),
          size: int.parse(item["size"].toString()),
          account: item["account"].toString(),
          filetype: item["filetype"].toString(),
          orgaId: item["orgaId"].toString(),
          userId: item["userId"].toString(),
          associated: item["associated"].toString().toLowerCase() == 'true',
          enabled: item["enabled"].toString().toLowerCase() == 'true',
          builtIn: item["builtIn"].toString().toLowerCase() == 'true',
          created: DateTime.parse(item["created"]),
          updated:
              item["updated"] == null ? null : DateTime.parse(item["updated"]),
          deleted:
              item["deleted"] == null ? null : DateTime.parse(item["deleted"]),
          expires: item["expires"] == null
              ? null
              : DateTime.parse(item["expires"])));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CloudFileModel> registerCloudFile(String userId, String orgaId) async {
    final Map<String, dynamic> registerData = {
      'orgaId': orgaId,
      'userId': userId
      };
    final url = Uri.parse('${UrlBackend.base}/api/v1/storage/');
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

      return Future.value(CloudFileModel(
          id: item["id"].toString(),
          name: item["name"].toString(),
          path: item["path"].toString(),
          host: item["host"].toString(),
          url: item["url"].toString(),
          size: int.parse(item["size"].toString()),
          account: item["account"].toString(),
          filetype: item["filetype"].toString(),
          orgaId: item["orgaId"].toString(),
          userId: item["userId"].toString(),
          associated: item["associated"].toString().toLowerCase() == 'true',
          enabled: item["enabled"].toString().toLowerCase() == 'true',
          builtIn: item["builtIn"].toString().toLowerCase() == 'true',
          created: DateTime.parse(item["created"]),
          updated:
              item["updated"] == null ? null : DateTime.parse(item["updated"]),
          deleted:
              item["deleted"] == null ? null : DateTime.parse(item["deleted"]),
          expires: item["expires"] == null
              ? null
              : DateTime.parse(item["expires"])));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CloudFileModel> getCloudFile(String cloudFileId) async {

    final url = Uri.parse('${UrlBackend.base}/api/v1/storage/$cloudFileId');
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

      return Future.value(CloudFileModel(
          id: item["id"].toString(),
          name: item["name"].toString(),
          path: item["path"].toString(),
          host: item["host"].toString(),
          url: item["url"].toString(),
          size: int.parse(item["size"].toString()),
          account: item["account"].toString(),
          filetype: item["filetype"].toString(),
          orgaId: item["orgaId"].toString(),
          userId: item["userId"].toString(),
          associated: item["associated"].toString().toLowerCase() == 'true',
          enabled: item["enabled"].toString().toLowerCase() == 'true',
          builtIn: item["builtIn"].toString().toLowerCase() == 'true',
          created: DateTime.parse(item["created"]),
          updated:
              item["updated"] == null ? null : DateTime.parse(item["updated"]),
          deleted:
              item["deleted"] == null ? null : DateTime.parse(item["deleted"]),
          expires: item["expires"] == null
              ? null
              : DateTime.parse(item["expires"])));
    } else {
      throw ServerException();
    }
  }
}
