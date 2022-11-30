import '../../../../../core/constants.dart';
import '../../../../../core/exceptions.dart';

import 'package:http/http.dart' as http;

import '../models/token_model.dart';

abstract class RemoteDataSource {
  Future<TokenModel> getAuthenticate(String username, String password);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<TokenModel> getAuthenticate(String username, String password) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      return TokenModel(id: username, username: username);
    } else {
      throw ServerException();
    }
  }
}
