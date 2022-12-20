import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../exceptions.dart';
import '../models/session_model.dart';

abstract class LocalDataSource {
  Future<SessionModel> getSavedSession();
  Future<bool> saveSession(SessionModel session);
  Future<bool> hasSession();
  Future<bool> cleanSession();
}

const cachedSessionKey = "SESSION_KEY";

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<SessionModel> getSavedSession() {
    final jsonString = sharedPreferences.getString(cachedSessionKey);
    if (jsonString != null && jsonString != "") {
      return Future.value(SessionModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> cleanSession() {
    sharedPreferences.setString(
      cachedSessionKey,
      "",
    );

    return Future.value(true);
  }

  @override
  Future<bool> saveSession(SessionModel session) {
    sharedPreferences.setString(
      cachedSessionKey,
      json.encode(session.toJson()),
    );

    return Future.value(true);
  }

  @override
  Future<bool> hasSession() {
    return Future.value(sharedPreferences.containsKey(cachedSessionKey));
  }
}