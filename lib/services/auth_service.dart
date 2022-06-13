import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'http://localhost:8187';
  //final String token = '';
  final storage = const FlutterSecureStorage();
  bool isLoading = true;

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'username': email,
      'password': password
    };

    final url = Uri.parse('http://localhost:8187/api/v1/User/authenticate');

    http.Response? resp;
    Map<String, dynamic>? decodedResp;

    try {
      print(json.encode(authData));
      resp = await http.post(url, body: json.encode(authData), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        //'Authorization': 'Bearer ${readToken()}',
      });
      decodedResp = json.decode(resp.body);
      print(decodedResp);
    } catch (e) {
      print(e.toString());
    }

    if (resp?.statusCode == 200) {
      print('resultado = 200');
      await storage.write(key: 'token', value: decodedResp!['token']);
      await storage.write(key: 'user', value: decodedResp['username']);
      return null;
    } else {
      print('error');
      return decodedResp!['message'];
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