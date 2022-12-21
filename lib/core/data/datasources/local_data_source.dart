import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../exceptions.dart';
import '../models/session_model.dart';

///En estas clases de define la interfaz y se implementa la clase que se
///comunica con el Storage local del sistema, ya sea Android, iOS o Web.
///De este modo guardamos en el "local" la información de sesión, para saber
///quién es el usuario, contar con el token y los roles que tiene dentro de
///la aplicación.

///Clase de interfaz que define la estructura que tendrá el LocalDataSource
abstract class LocalDataSource {
  Future<SessionModel> getSavedSession();
  Future<bool> saveSession(SessionModel session);
  Future<bool> hasSession();
  Future<bool> cleanSession();
}

///Define el nombre que tiene la variable para almacenar la Sesión.
const cachedSessionKey = "SESSION_KEY";

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  ///Implementa el método que entrega el [SessionModel] desde el localStorage
  ///
  ///Lanza una [CacheException] si no fue posible leer el localStorage con
  ///esa clave [cachedSessionKey]
  @override
  Future<SessionModel> getSavedSession() {
    final jsonString = sharedPreferences.getString(cachedSessionKey);
    if (jsonString != null && jsonString != "") {
      return Future.value(SessionModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  ///Limpia el valor de la sesión guardada en la clave [cachedSessionKey] del
  ///localStorage
  @override
  Future<bool> cleanSession() {
    sharedPreferences.setString(
      cachedSessionKey,
      "",
    );

    return Future.value(true);
  }

  ///Persiste el valor de la sesión en [session] hacia el localStorage
  @override
  Future<bool> saveSession(SessionModel session) {
    sharedPreferences.setString(
      cachedSessionKey,
      json.encode(session.toJson()),
    );

    return Future.value(true);
  }

  ///Verdadero si existe un valor en la clave [cachedSessionKey] de localStorage
  @override
  Future<bool> hasSession() {
    return Future.value(sharedPreferences.containsKey(cachedSessionKey));
  }
}
