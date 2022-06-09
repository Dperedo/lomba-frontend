import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'http://localhost:8187';
  final storage = const FlutterSecureStorage();
  bool isLoading = true;

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'username': email,
      'password': password
    };
    print('1');

    final url = Uri.parse('http://localhost:8187/api/v1/User/authenticate');

    print('2');

    http.Response? resp;
    Map<String, dynamic>? decodedResp;

    try {
      print(json.encode(authData));
      resp = await http.post(url, body: json.encode(authData), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*"
      });
      decodedResp = json.decode(resp.body);
      print(decodedResp);
    } catch (e) {
      print(e.toString());
    }

    if (resp?.statusCode == 200) {}

    print('3');
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
