import 'dart:async';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:front_lomba/helpers/preferences.dart';
import 'package:front_lomba/providers/url_provider.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = Preferences.baseUrl;
  //final String token = '';
  final storage = const FlutterSecureStorage();
  bool isLoading = true;

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'username': email,
      'password': password
    };

    final url = Uri.parse('$_baseUrl/api/v1/User/authenticate');

    http.Response? resp;
    Map<String, dynamic>? decodedResp;
    //print(authData);
    //print(menuProvider.loadData());
    try {
      //print(json.encode(authData));
      resp = await http.post(url, body: json.encode(authData), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        //'Authorization': 'Bearer ${readToken()}',
      }).timeout(const Duration(seconds: 10));
      decodedResp = json.decode(resp.body);
      //print(decodedResp);
    } on TickerFuture catch (e) {
      print(e.toString());
      return 'Conexión con el servidor no establecido';
    } catch (e) {
      return 'Conexión con el servidor no establecido timeout';
    }

    if (resp.statusCode == 200) {
      print('resultado = 200');
      await storage.write(key: 'token', value: decodedResp!['token']);
      await storage.write(key: 'user', value: decodedResp['username']);
      return null;
    } else {
      print('error');
      return decodedResp!['message'];
    }

  }

  Future<bool> Ping() async {

    final url = Uri.parse('$_baseUrl/api/Ping');

    http.Response? resp;
    Map<String, dynamic>? decodedResp;

    try {
      //print(json.encode(authData));
      resp = await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        'Authorization': 'Bearer ${readToken()}',
      });
      decodedResp = json.decode(resp.body);
      //print(decodedResp);
    } catch (e) {
      print(e.toString());
      return false;
      //throw ('Tiempo de espera alcanzado');
    } 

    if (resp.statusCode == 200) {
      print('resultado = 200');
      return true;
    } else {
      print('error');
      return false;
    }

  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  String datoPrueba() {
    return 'eltokenfalse';
  }

  Future<String> readPermiso() async {
    String token;
    token = await storage.read(key: 'token') ?? '';
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['role'];
  }
}
