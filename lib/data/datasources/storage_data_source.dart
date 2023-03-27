import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';
import '../../core/exceptions.dart';
import '../models/storage/filecloud_model.dart';
import 'local_data_source.dart';

abstract class StorageRemoteDataSource {
  Future<FileCloudModel> uploadFile(
      Uint8List file, String name, String userId, String orgaId);
}

class StorageRemoteDataSourceImpl implements StorageRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  StorageRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<FileCloudModel> uploadFile(
      Uint8List file, String name, String userId, String orgaId) async {
    final session = await localDataSource.getSavedSession();
    final url = Uri.parse('${UrlBackend.base}/api/v1/storage');

    //busca respuesta desde el servidor para la autenticación
/*
    final fileEncoded = base64Encode(file);
    final Map<String, dynamic> dataToPost = {
      'fileEncoded': fileEncoded,
    };
*/

    var request = http.MultipartRequest('POST', url);

    request.files
        .add(http.MultipartFile.fromBytes("file", file, filename: name));
    request.fields.addAll({'name': name, 'userId': userId, 'orgaId': orgaId});

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
      return Future.value(FileCloudModel(
          id: item["id"].toString(),
          name: item["name"].toString(),
          path: item["path"].toString(),
          url: item["url"].toString(),
          size: int.parse(item["size"].toString()),
          account: item["account"].toString(),
          filetype: item["filetype"].toString(),
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
