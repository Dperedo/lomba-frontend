import '../../../../../core/constants.dart';
import '../../../../../core/exceptions.dart';

import 'package:http/http.dart' as http;

import '../models/login_access_model.dart';

///Interfaz para el DataSource remoto del Login
abstract class RemoteDataSource {
  Future<LoginAccessModel> getAuthenticate(String username, String password);
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
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName("London")));

    if (response.statusCode == 200) {
      if (username.contains('rev')) {
        return LoginAccessModel(
            token: SystemKeys.tokenReviewed,
            username: username,
            name: 'Revisor');
      } else {
        return LoginAccessModel(
            token: SystemKeys.tokenSuperAdmin2023,
            username: username,
            name: 'Miguel');
      }
    } else {
      throw ServerException();
    }
  }
}
