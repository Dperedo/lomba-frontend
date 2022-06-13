import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_lomba/screens/administration/permissions_screen.dart';

import 'package:http/http.dart' as http;

class PermissionsService extends ChangeNotifier {
  final String _baseUrl = 'http://localhost:8187';
  //final String token = '';
  final storage = const FlutterSecureStorage();
  bool isLoading = true;
  //Map<String, dynamic>? decodedResp;

  Future<List<dynamic>?> PermissionsList() async {

    final url = Uri.parse('http://localhost:8187/api/v1/Role');

    http.Response? resp;
    List<dynamic>? decodedResp;

    try {
      resp = await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        'Authorization': 'Bearer ${await readToken()}',
      });
      decodedResp = json.decode(resp.body);
      print(decodedResp);
    } catch (e) {
      print(e.toString());
    }

    if (resp?.statusCode == 200) {
      print('resultado = 200');
      print(decodedResp);
      return decodedResp;
    } else {
      print('error');
      return null;
    }

  }
/*
  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }*/

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
/*
  String datoPrueba() {
    return 'eltokenfalse';
  }

  Future<String> readPermiso() async {
    String token;
    token = await storage.read(key: 'token') ?? '';
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['role'];
  }*/
}