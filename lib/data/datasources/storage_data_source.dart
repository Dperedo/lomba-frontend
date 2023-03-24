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
    http.Response resp = await client.post(url, body: "", headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];
      return Future.value(FileCloudModel(
          id: item["id"],
          name: item["name"],
          path: item["path"],
          url: item["url"],
          size: item["size"],
          account: item["account"],
          filetype: item["filetype"],
          enabled: item["enabled"],
          builtIn: item["builtIn"],
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
