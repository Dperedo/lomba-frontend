import 'dart:convert';

import 'package:lomba_frontend/features/login/data/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/exceptions.dart';

abstract class LocalCacheDataSource {
  Future<TokenModel> getSavedToken();
  Future<void> saveToken(TokenModel token);
  Future<bool> hasToken();
}

const CACHED_TOKEN_KEY = "TOKEN_KEY";

class LoginLocalDataSourceImpl implements LocalCacheDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<TokenModel> getSavedToken() {
    final jsonString = sharedPreferences.getString(CACHED_TOKEN_KEY);
    if (jsonString != null && jsonString != "") {
      return Future.value(TokenModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveToken(TokenModel token) {
    return sharedPreferences.setString(
      CACHED_TOKEN_KEY,
      json.encode(token.toJson()),
    );
  }

  @override
  Future<bool> hasToken() {
    return Future.value(sharedPreferences.containsKey(CACHED_TOKEN_KEY));
  }
}
