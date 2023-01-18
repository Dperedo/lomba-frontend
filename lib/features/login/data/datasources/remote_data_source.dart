import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lomba_frontend/features/login/domain/usecases/register_user.dart';
import 'package:lomba_frontend/features/users/data/models/user_model.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/exceptions.dart';
import '../models/login_access_model.dart';

///Interfaz para el DataSource remoto del Login
abstract class RemoteDataSource {
  Future<LoginAccessModel> getAuthenticate(String username, String password);
  Future<bool> registerUser(UserModel usermodel, String orgaId, String password, String role);
}

///Implementación del Data Source Remoto para la autenticación de usuario.
class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  ///A partir del usuario y password consigue un [LoginAccessModel] con
  ///el token del usuario y demás información.
  @override
  Future<LoginAccessModel> getAuthenticate(
      String username, String password) async {
    final Map<String, dynamic> authData = {
      'username': username,
      'password': password
    };

    //parsea URL
    final url = Uri.parse('${UrlBackend.base}/api/v1/auth');

    //busca respuesta desde el servidor para la autenticación
    http.Response resp =
        await client.post(url, body: json.encode(authData), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      return LoginAccessModel(
          token: resObj['data']['items'][0]['value'].toString(),
          username: username,
          name: username);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> registerUser(
      UserModel usermodel, String orgaId, String password, String role) async {
    final Map<String, dynamic> authData = {
      'username': usermodel.username,
      'password': password,
      'orgaId': orgaId
    };
    final Map<String, dynamic> regData = {
      'user': usermodel,
      'auth': authData,
      'roles': role
    };

    //parsea URL
    final url = Uri.parse('${UrlBackend.base}/api/v1/auth/registration');

    //busca respuesta desde el servidor para la autenticación
    http.Response resp =
        await client.post(url, body: json.encode(regData), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    }).timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      return true;
    } else {
      throw ServerException();
    }
  }
}
